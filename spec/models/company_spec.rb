require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { build(:company) }

  it "should create a valid company" do
    expect(company).to be_valid
  end

  [:name, :cnpj, :address, :neighborhood, :phone, :email, :state, :city, :zip_code, :status, :business, :user_id].each do |attribute|
    it "should not create a company without a #{attribute}" do
      company[attribute] = nil
      expect(company).to_not be_valid
    end
  end

  it "should not create a company without a correct email" do
    company.email = "teste"
    expect(company).to_not be_valid
  end

  it "should not create a company with a cnpj that already exists" do
    create(:company, cnpj: "existing_cnpj")
    company.cnpj = "existing_cnpj"
    expect(company).to_not be_valid
  end

  it "should not create a company with an email that already exists" do
    create(:company, email: "existing_email@example.com")
    company.email = "existing_email@example.com"
    expect(company).to_not be_valid
  end
end
