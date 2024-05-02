class ServiceOrder < ApplicationRecord
  belongs_to :company
  belongs_to :customer

  validates :company_id, presence: true
  validates :customer_id, presence: true
  validates :services, presence: true
  validates :total, presence: true
end
