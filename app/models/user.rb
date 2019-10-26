class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }
end
