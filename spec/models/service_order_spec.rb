require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  it "shoud create a valid service order" do
    company = create(:company)
    customer = create(:customer, company_id: company.id)
    service_order = create(:service_order, company_id: company.id, customer_id: customer.id)
    expect(service_order).to be_valid
  end

  it "should not create a service order without a company" do
    company = create(:company)
    customer = create(:customer, company_id: company.id)
    service_order = build(:service_order, company_id: nil, customer_id: customer.id)
    expect(service_order).to_not be_valid
  end

  it "should not create a service order without a customer" do
    company = create(:company)
    service_order = build(:service_order, company_id: company.id, customer_id: nil)
    expect(service_order).to_not be_valid
  end

  it "should not create a service order without services" do
    company = create(:company)
    customer = create(:customer, company_id: company.id)
    service_order = build(:service_order, company_id: company.id, customer_id: customer.id, services: nil)
    expect(service_order).to_not be_valid
  end

  it "should not create a service order without a total" do
    company = create(:company)
    customer = create(:customer, company_id: company.id)
    service_order = build(:service_order, company_id: company.id, customer_id: customer.id, total: nil)
    expect(service_order).to_not be_valid
  end
end
