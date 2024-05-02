require 'rails_helper'

RSpec.describe Budget, type: :model do
  it "should create a valid budget" do
    company = create(:company)
    budget = create(:budget, company_id: company.id)
    expect(budget).to be_valid
  end

  it "should not create a budget without a company" do
    budget = build(:budget, company_id: nil)
    expect(budget).to_not be_valid
  end

  it "should not create a budget without a customer name" do
    company = create(:company)
    budget = build(:budget, company_id: company.id, customer_name: nil)
    expect(budget).to_not be_valid
  end

  it "should not create a budget without a customer phone" do
    company = create(:company)
    budget = build(:budget, company_id: company.id, customer_phone: nil)
    expect(budget).to_not be_valid
  end

  it "should not create a budget without services" do
    company = create(:company)
    budget = build(:budget, company_id: company.id, services: nil)
    expect(budget).to_not be_valid
  end

  it "should not create a budget without a total" do
    company = create(:company)
    budget = build(:budget, company_id: company.id, total: nil)
    expect(budget).to_not be_valid
  end
end
