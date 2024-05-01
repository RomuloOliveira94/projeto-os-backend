require 'rails_helper'

RSpec.describe "Api::V1::Auths", type: :request do
  describe "POST /login" do
    it "missing params" do
      post "/api/v1/auth/login"
      expect(response).to have_http_status(:bad_request)
    end

    it "user not found" do
      post "/api/v1/auth/login", params: { email: "teste@gmail.com", password: "teste123" }
      expect(response).to have_http_status(:not_found)
    end

    it "user not authenticated" do
      user = create(:user)
      post "/api/v1/auth/login", params: { email: user.email, password: "teste123" }
      expect(response).to have_http_status(:unauthorized)
    end

    it "user authenticated" do
      user = create(:user)
      post "/api/v1/auth/login", params: { email: user.email, password: user.password }
      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(parsed_body).to include("token")
    end
  end

  describe "POST /signup" do
    it "missing params" do
      post "/api/v1/auth/signup"
      expect(response).to have_http_status(:bad_request)
    end

    it "password too short" do
      post "/api/v1/auth/signup", params: { email: "teste@gmail.com", password: "12345", name: "Teste" }
      expect(response).to have_http_status(:bad_request)
    end

    it "user already exists" do
      user = create(:user)
      post "/api/v1/auth/signup", params: { email: user.email, password: user.password, name: user.name }
      expect(response).to have_http_status(:bad_request)
    end

    it "error to create user" do
      post "/api/v1/auth/signup", params: { email: "teste", password: "teste1", name: "Teste" }
      expect(response).to have_http_status(:bad_request)
    end

    it "valid user" do
      user = create(:user)
      post "/api/v1/auth/signup", params: { email: "teste@c.com", password: user.name, name: user.name }
      expect(response).to have_http_status(:ok)
    end
  end
end
