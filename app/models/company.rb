class Company < ApplicationRecord
  belongs_to :user
  enum company_status: { active: 0, inactive: 1 }
  emum business_type: { tecnical_assistance: 0, services: 1 }
end
