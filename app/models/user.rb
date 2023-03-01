# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true

  has_many :tasks
end
