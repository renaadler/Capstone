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

  def update_step_status
    if user_status == "Green" && connection_status == "Green"
      self.update(step_id: step_id + 1, step_status: "Not Yet Updated")
      inverse_relationship.update(step_id: step_id + 1, step_status: "Not Yet Updated")
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
  end
end
