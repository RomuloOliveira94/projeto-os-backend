require 'rails_helper'

RSpec.describe "Api::V1::Customers", type: :request do
  before(:each) do
    @user = create(:user)
    @company = create(:company, user: @user)
    @customer =  build(:customer, company_id: @company.id)
    @token = JWT.encode({ user_id: @user.id }, Rails.application.credentials.secret_key_base)
    @headers = { 'Authorization' => "Bearer #{@token}" }
  end

  describe "GET /index" do
   it "returns http success" do
      customers = Customer.all
      get "/api/v1/customers", headers: @headers
      expect(response.body).to eq(customers.to_json)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/api/v1/customers", params: { customer: @customer.attributes }, headers: @headers
      expect(response).to have_http_status(:success)
    end

    it "returns http unprocessable_entity" do
      post "/api/v1/customers", params: { customer: { name: nil } }, headers: @headers
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns http unauthorized" do
      post "/api/v1/customers", params: { customer: @customer.attributes }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PUT /update" do
    it "returns http success" do
      @customer.save
      @customer.name = "Updated Name"
      put "/api/v1/customers/#{@customer.id}", params: { customer: @customer.attributes }, headers: @headers
      expect(response).to have_http_status(:success)
    end

    it "returns http not_found" do
      put "/api/v1/customers/0", params: { customer: @customer.attributes }, headers: @headers
      expect(response).to have_http_status(:not_found)
    end

    it "returns http unprocessable_entity" do
      @customer.save
      put "/api/v1/customers/#{@customer.id}", params: { customer: { name: nil } }, headers: @headers
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns http unauthorized" do
      @customer.save
      put "/api/v1/customers/0", params: { customer: @customer.attributes }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE /destroy" do
    it "returns http success" do
      @customer.save
      delete "/api/v1/customers/#{@customer.id}", headers: @headers
      expect(response).to have_http_status(:success)
    end

    it "returns http not_found" do
      delete "/api/v1/customers/0", headers: @headers
      expect(response).to have_http_status(:not_found)
    end

    it "returns http unauthorized" do
      @customer.save
      delete "/api/v1/customers/#{@customer.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
