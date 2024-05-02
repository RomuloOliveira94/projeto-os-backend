class Budget < ApplicationRecord
  belongs_to :company

  validates :company_id, presence: true
  validates :customer_name, presence: true
  validates :customer_phone, presence: true
  validates :services, presence: true
  validates :total, presence: true
end
