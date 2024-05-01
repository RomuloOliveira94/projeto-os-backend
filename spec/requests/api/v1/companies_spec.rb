require 'rails_helper'

RSpec.describe "Api::V1::Companies", type: :request, focus: true do
  before(:each) do
    @user = create(:user)
    @token = JWT.encode({ user_id: @user.id }, Rails.application.credentials.secret_key_base)
    @headers = { 'Authorization' => "Bearer #{@token}" }
  end

  describe "GET /index" do
    it "returns http success" do
      companies = create_list(:company, 10)
      get "/api/v1/companies", headers: @headers
      expect(response.body).to eq(companies.to_json)
      expect(response).to have_http_status(:success)
    end

    it "returns http success with no companies" do
      get "/api/v1/companies", headers: @headers

      expect(response.body).to eq([].to_json)
      expect(response).to have_http_status(:success)
    end

    it "returns http success with one company" do
      company = create(:company)
      get "/api/v1/companies", headers: @headers
      expect(response.body).to eq([company].to_json)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      company = create(:company)
      get "/api/v1/companies/#{company.id}", headers: @headers
      expect(response).to have_http_status(:success)
    end

    it "returns http not found" do
      get "/api/v1/companies/0", headers: @headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      company = build(:company)
      post "/api/v1/companies", headers: @headers, params: { company: company.attributes }
      expect(response).to have_http_status(:success)
    end

    it "returns http unprocessable entity" do
      company = build(:company, name: nil)
      post "/api/v1/companies", headers: @headers, params: { company: company.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /update" do
    it "returns http success" do
      company = create(:company)
      company.name = "New Name"
      put "/api/v1/companies/#{company.id}", headers: @headers, params: { company: company.attributes }
      expect(response).to have_http_status(:success)
    end

    it "returns http not found" do
      put "/api/v1/companies/0", headers: @headers, params: { company: {} }
      expect(response).to have_http_status(:not_found)
    end

    it "returns http unprocessable entity" do
      company = create(:company)
      company.name = nil
      put "/api/v1/companies/#{company.id}", headers: @headers, params: { company: company.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
