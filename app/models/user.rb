class User < ApplicationRecord
  has_secure_password
  has_many :orders

  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :role, presence: true
  validates :email, presence: true
  # validates :password, presence: true
  # validates :password, length: { minimum: 4 }
  validates :email, uniqueness: true
  # validates :password, confirmation: true
end