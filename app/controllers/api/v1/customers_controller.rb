class Api::V1::CustomersController < ApplicationController
  include Authentication

  def index
    @customers = Customer.all
    render status: :ok, json: @customers
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render status: :ok, json: @customer
    else
      render status: :unprocessable_entity, json: { errors: @customer.errors }
    end
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.nil?
      render status: :not_found, json: { error: "Customer not found" }
      return
    end

    if @customer.update(customer_params)
      render status: :ok, json: @customer
    else
      render status: :unprocessable_entity, json: { errors: @customer.errors }
    end
  end

  def destroy
    @customer = Customer.find(params[:id])

    if @customer.nil?
      render status: :not_found, json: { error: "Customer not found" }
      return
    end

    @customer.destroy
    render status: :ok, json: { message: "Customer deleted" }
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :phone, :company_id, :email, :address, :address_number, :address_complement, :neighborhood, :city, :state, :zip_code, :cpf_cnpj)
  end
end
