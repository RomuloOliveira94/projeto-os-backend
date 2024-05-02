require 'rails_helper'

RSpec.describe Customer, type: :model, focus: true do
  it "is valid with name and phone" do
    company = create(:company)
    customer = create(:customer, company_id: company.id)
    expect(customer).to be_valid
  end

  it "is invalid without name" do
    company = create(:company)
    customer = build(:customer, name: nil, company_id: company.id)
    customer.valid?
    expect(customer.errors[:name]).to include("can't be blank")
  end

  it "is invalid without phone" do
    company = create(:company)
    customer = build(:customer, phone: nil, company_id: company.id)
    customer.valid?
    expect(customer.errors[:phone]).to include("can't be blank")
  end
end
