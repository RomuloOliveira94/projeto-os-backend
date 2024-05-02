require 'rails_helper'

RSpec.describe "Api::V1::ServiceOrders", type: :request, focus: true do
  before(:each) do
    @user = create(:user)
    @company = create(:company, user: @user)
    @customer =  build(:customer, company_id: @company.id)
    @customer.save
    @service_order = build(:service_order, customer_id: @customer.id, company_id: @company.id)
    @token = JWT.encode({ user_id: @user.id }, Rails.application.credentials.secret_key_base)
    @headers = { 'Authorization' => "Bearer #{@token}" }
  end

  describe "GET /index" do
    it "returns http success" do
      service_orders = ServiceOrder.all
      get "/api/v1/service_orders", headers: @headers
      expect(response.body).to eq(service_orders.to_json)
      expect(response).to have_http_status(:success)
    end

    it "returns http unauthorized" do
      get "/api/v1/service_orders"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      @service_order.save
      get "/api/v1/service_orders/#{@service_order.id}", headers: @headers
      expect(response).to have_http_status(:success)
    end

    it "returns http unauthorized" do
      @service_order.save
      get "/api/v1/service_orders/#{@service_order.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/api/v1/service_orders", params: { service_order: @service_order.attributes }, headers: @headers
      expect(response).to have_http_status(:created)
    end

    it "returns http unprocessable_entity" do
      post "/api/v1/service_orders", params: { service_order: { company_id: nil } }, headers: @headers
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns http unauthorized" do
      @service_order.save
      post "/api/v1/service_orders", params: { service_order: @service_order.attributes }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE /destroy" do
    it "returns http success" do
      @service_order.save
      delete "/api/v1/service_orders/#{@service_order.id}", headers: @headers
      expect(response).to have_http_status(:success)
    end

    it "returns http unauthorized" do
      @service_order.save
      delete "/api/v1/service_orders/#{@service_order.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
