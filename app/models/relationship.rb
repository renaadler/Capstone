class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :connection, class_name: "User"
  has_many :messages
  belongs_to :step
end
