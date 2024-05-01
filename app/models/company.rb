class Company < ApplicationRecord
  belongs_to :user
  enum status: { active: 0, inactive: 1 }
  enum business: { tecnical_assistance: 0, services: 1 }

  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: true
  validates :address, presence: true
  validates :neighborhood, presence: true
  validates :phone, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :state, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :status, presence: true
  validates :business, presence: true
  validates :user_id, presence: true 

  def payment_methods_enum
    %w[pix credit_card debit_card cash boleto]
  end
end
