class Api::V1::AuthController < ApplicationController
  def login
    if params[:email].nil? || params[:password].nil?
      render status: :bad_request, json: { error: "Missing params" }
      return
    end

    unless @user = User.find_by(email: params[:email])
      render status: :not_found, json: { error: "Error to login" }
      return
    end

    if @user&.authenticate(params[:password])
      payload = { user_id: @user.id }
      token = JWT.encode payload , Rails.application.credentials.secret_key_base, 'HS256'
      render json: { token: token, "exp": Time.now + 72.hours.to_int, "username": @user.name }, status: :ok
      return
    else
      render status: :unauthorized, json: { error: "Error to login" }
    end
  end

  def signup
    if params[:email].nil? || params[:password].nil? || params[:name].nil?
      render status: :bad_request, json: { error: "Missing params" }
      return
    end

    if params[:password].length < 6
      render status: :bad_request, json: { error: "Password too short" }
      return
    end

    @user = User.find_by(email: params[:email])

    if @user
      render status: :bad_request, json: { error: "User already exists" }
      return
    end

    @new_user = User.new(email: params[:email], password: params[:password], name: params[:name])

    unless @new_user.save
      render status: :bad_request, json: { error: "Error to create user" }
      return
    end

    render status: :ok
  end
end
