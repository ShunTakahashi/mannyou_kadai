class User < ApplicationRecord
  has_many :tasks

  validates :name, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  has_secure_password
  validates :password, presence: true, length: {minimum: 8}, on: :create
end
