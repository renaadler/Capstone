class User < ApplicationRecord
  has_secure_password
  has_many :relationships
  has_many :connections, through: :relationships, class_name: "User"
  has_many :messages, through: :relationships


  def not_yet_updated_relationships
    relationships.where(connected_status: "Connected", step_status: "Not Yet Updated")
  end

  def yellow_status_relationships
    relationships.where(connected_status: "Connected", step_status: "Yellow")
  end
end
