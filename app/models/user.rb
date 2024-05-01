class User < ApplicationRecord
  has_secure_password
  has_many :companies
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true, length: { minimum: 6 }
end
