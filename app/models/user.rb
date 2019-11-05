class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  has_secure_password
  validates :password, presence: true, length: {minimum: 8}, on: :create

  before_destroy :check_admin_user_count

  private

  def check_admin_user_count
    if admin? && User.where(admin: true).count == 1
      throw :abort
    end
  end
end
