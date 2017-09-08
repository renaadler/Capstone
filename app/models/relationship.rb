class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :connection, class_name: "User"
  has_many :messages
  belongs_to :step
  

  def user_status
    step_status
  end

  def inverse_relationship
    connection.relationships.find_by(connection_id: user_id)
  end

  def connection_status
    if inverse_relationship
      inverse_relationship.step_status
    else
      "Unavailable"
    end
  end

  def connect
    self.update(connected_status: "Connected", step_status: "Not Yet Updated")
    inverse_relationship.update(connected_status: "Connected", step_status: "Not Yet Updated")
  end
  def reconnect
    self.update(connected_status: "Pending", step_id: 1)
    inverse_relationship.update(connected_status: "Pending", step_id: 1) 
  end

  def update_step_status
    if user_status == "Green" && connection_status == "Green"
      new_step_id = step_id + 1
      self.update(step_id: new_step_id, connected_status: "Connected", step_status: "Not Yet Updated")
      inverse_relationship.update(step_id: new_step_id, connected_status: "Connected", step_status: "Not Yet Updated")
    end
    if user_status == "Red" || connection_status == "Red"
      self.update(connected_status: "Disconnected", step_status: "Unavailable")
      # self.connected_status = "Disconnected"
      # self.step_status = "Unavailable"
      inverse_relationship.update(connected_status: "Disconnected", step_status: "Unavailable")
      # inverse_relationship.connected_status = "Disconnected"
      # inverse_relationship.step_status = "Unavailable"

      # self.save
      # inverse_relationship.save
    end
     # Rufus::Scheduler.singleton.in '10s' do
     #    # put your own credentials here
     #    account_sid = 'AC22b2dbe233dc0027d95bad6081c82727'
     #    auth_token = 'e0a6cc934dc3b1233dbec7f66b250f7d'
     #    # set up a client to talk to the Twilio REST API
     #    @client = Twilio::REST::Client.new account_sid, auth_token
     #    # alternatively, you can preconfigure the client like so
     #    Twilio.configure do |config|
     #      config.account_sid = account_sid
     #      config.auth_token = auth_token
     #    end
     #    # and then you can create a new client without parameters
     #    @client = Twilio::REST::Client.new
     #    @client.api.account.messages.create(
     #      from: '+19472224327',
     #      to: '+13134919672',
     #      body: 'This is in my model'
     #    )
     #    # Rails.logger.info "time flies, it's now #{Time.now}"
     #  end 
  end
end
