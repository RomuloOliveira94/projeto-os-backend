class Api::V1::ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: %i[show destroy]
  include Authentication

  def index
    @service_orders = ServiceOrder.all
    render status: :ok, json: @service_orders
  end

  def show
    render json: @service_order, status: :ok
  end

  def create
    @service_order = ServiceOrder.new(service_order_params)

    if @service_order.save
      render  status: :created, json: @service_order
    else
      render  status: :unprocessable_entity, json: { errors: @service_order.errors }
    end
  end

  def destroy
    @service_order.destroy
  end

  private

  def service_order_params
    params.require(:service_order).permit(:company_id, :customer_id, :start_date, :end_date, {products: [:name, :details]} , {materials: [:name, :price]}, :other_fees, :observations, :subtotal, :discount, :total, {services: [:name, :details, :price]})
  end

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end
end
