class Api::V1::RelationshipsController < ApplicationController
  def index
    @relationships = current_user.relationships
    render "index.json.jbuilder"
  end
  
  def update
    relationship_id = params[:id]
    @relationship = Relationship.find_by(id: relationship_id)
    if params[:step_status]
      @relationship.step_status = params[:step_status]
      @relationship.update_step_status
      @relationship.save
      # puts "somereallylongobnoxiousstring"
      Rufus::Scheduler.singleton.in '3s' do
        # put your own credentials here
        account_sid = 'AC22b2dbe233dc0027d95bad6081c82727'
        auth_token = 'e0a6cc934dc3b1233dbec7f66b250f7d'
        # set up a client to talk to the Twilio REST API
        @client = Twilio::REST::Client.new account_sid, auth_token
        # alternatively, you can preconfigure the client like so
        Twilio.configure do |config|
          config.account_sid = account_sid
          config.auth_token = auth_token
        end
        # and then you can create a new client without parameters
        @client = Twilio::REST::Client.new
        @client.api.account.messages.create(
          from: '+19472224327',
          to: '+13134919672',
          body: 'Please update your status'
        )
        # Rails.logger.info "time flies, it's now #{Time.now}"
      end
      ActionCable.server.broadcast 'activity_channel', {
        relationship_id: @relationship.inverse_relationship.id,
        step_id: @relationship.step.id,
        step_status: @relationship.step_status,
        inverse_step_status: @relationship.inverse_relationship.step_status
      }
    end
    render "show.json.jbuilder"
  end

  def show
    relationship_id = params[:id]
    @relationship = Relationship.find_by(id: relationship_id)
    render "show.json.jbuilder"
  end
end
