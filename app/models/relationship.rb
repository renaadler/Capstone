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
end
