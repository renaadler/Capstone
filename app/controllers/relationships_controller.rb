class RelationshipsController < ApplicationController
  
  def index
    if current_user
      if current_user.relationships.count > 0
        @relationships = current_user.relationships
        @my_not_yet_updated = current_user.my_not_yet_updated_relationships
        @their_not_yet_updated = current_user.their_not_yet_updated_relationships
        @yellow_status = current_user.yellow_status_relationships
        @their_yellow_status = current_user.their_yellow_status_relationships
        # @not_yet_updated_relationships = @relationships.yellow_status_relationships
        render "index.html.erb"
      else
        flash[:warning] = "You have no connections. Get it going, person."
        redirect_to "/users"
      end
    else
      flash[:warning] = "You need to login. Get it going, person."
      redirect_to "/login"
    end
  end

  def create
    Relationship.create(user_id: current_user.id, connection_id: params[:connection_id], connected_status: "Initiating", step_id: 1, step_status: "Not Yet Updated")
    Relationship.create(user_id: params[:connection_id], connection_id: current_user.id, connected_status: "Pending", step_id: 1, step_status: "Not Yet Updated")
    redirect_to "/"
  end

  def show
    # current_user
    relationship_id = params[:id]
    @relationship = Relationship.find_by(id: relationship_id)
    render "show.html.erb"
  end

  def update
    relationship_id = params[:id]
    @relationship = Relationship.find_by(id: relationship_id)
    if params[:step_status]
      @relationship.step_status = params[:step_status]
      @relationship.update_step_status
      if @relationship.save
        flash[:success] = "Status Changed!"
        redirect_to "/relationships/#{@relationship.id}"
      else
        flash[:warning] = "Unable to update."
        render "show.html.erb"
      end
    else
      @relationship.connected_status = params[:connected_status]
      @relationship.reconnect
      if @relationship.save
        flash[:success] = "Status Changed!"
        redirect_to "/relationships/#{@relationship.id}"
      else
        flash[:warning] = "Unable to update."
        render "show.html.erb"
      end
    end
  end

  def pending
    # @relationship = Relationship.find_by(connected_status: "Pending")
    # @connection_id = @relationship.id
    # @pending_relationships = current_user.relationships.where(connected_status: "Pending").where.not(id: current_user.id)
    @pending_relationships = Relationship.where(connected_status: "Pending", user_id: current_user.id)
    render "pending.html.erb"
  end

  # Twilio.configure do |config|
  #   config.account_sid = AC22b2dbe233dc0027d95bad6081c82727
  #   config.auth_token = e0a6cc934dc3b1233dbec7f66b250f7d
  # end
  # # and then you can create a new client without parameters
  # @client = Twilio::REST::Client.new

  def pending_update
    relationship_id = params[:relationship_id]
    @relationship = Relationship.find_by(id: relationship_id)
    @relationship.connect
    if @relationship.save
      ActionCable.server.broadcast 'activity_channel', {
        relationship_id: @relationship.inverse_relationship.id,
        step_id: @relationship.step.id,
        step_status: @relationship.step_status,
        inverse_step_status: @relationship.inverse_relationship.step_status,
        next_step: @relationship.step.title,
        inverse_next_step: @relationship.inverse_relationship.step.title
      }
      flash[:success] = "Reconnected!"
      redirect_to "/relationships/#{@relationship.id}"
    else
      flash[:warning] = "Unable to reconnect."
      render "show.html.erb"
    end
  end

  def disconnected
    @disconnected_relationships = current_user.relationships.where(connected_status: "Disconnected")
    render "disconnected.html.erb"
  end

  def reconnect
    relationship_id = params[:relationship_id]
    @relationship = Relationship.find_by(id: relationship_id)
    @relationship.update(connected_status: "Connected", )
    @relationship.inverse_relationship.update(connected_status: "Connected")

    flash[:success] = "Reconnected!"
    redirect_to "/relationships/#{@relationship.id}"
  end
end
