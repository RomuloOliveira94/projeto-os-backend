class Api::V1::CompaniesController < ApplicationController
  before_action :authenticate_request

  def index
    @companies = Company.all
    render status: :ok, json: @companies
  end

  def show
    @company = Company.find(params[:id])

    if @company.nil?
      render status: :not_found, json: { error: "Company not found" }
      return
    end

    render status: :ok, json: @company
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      render status: :ok, json: @company
    else
      render status: :unprocessable_entity, json: { errors: @company.errors }
    end
  end

  def update
    @company = Company.find(params[:id])

    if @company.nil?
      render status: :not_found, json: { error: "Company not found" }
      return
    end

    if @company.update(company_params)
      render status: :ok, json: @company
    else
      render status: :unprocessable_entity, json: { errors: @company.errors }
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :cnpj, :address, :phone, :email, :neighborhood, :state, :city, :zip_code, :status, :business, :user_id)
  end

  def authenticate_request
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header
    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
      payload = decoded_token.first
      @current_user = User.find(payload['user_id'])
    rescue JWT::DecodeError
      render status: :unauthorized, json: { error: 'Unauthorized' }
    end
  end
end
