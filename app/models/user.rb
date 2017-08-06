class User < ApplicationRecord
  has_secure_password
  has_many :relationships
  has_many :connections, through: :relationships, class_name: "User"
  has_many :messages, through: :relationships
end
