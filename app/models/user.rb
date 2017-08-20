class User < ApplicationRecord
  has_secure_password
  has_many :relationships
  has_many :connections, through: :relationships, class_name: "User"
  has_many :messages, through: :relationships


  def their_yellow_status_relationships
    Relationship.all.where(connection_id: self.id, step_status: "Yellow")
  end

  def my_not_yet_updated_relationships
    self.relationships.where(connected_status: "Connected", step_status: "Not Yet Updated")
  end

  def their_not_yet_updated_relationships
    Relationship.all.where(connection_id: self.id, step_status: "Not Yet Updated")
  end

  def yellow_status_relationships
    self.relationships.where(connected_status: "Connected", step_status: "Yellow")
  end
end
