class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :get_user
  before_action :get_order, only: [:payment, :show]

  def show
  end

  def create
    order = Order.create(params.require(:order).permit(:address, :name, :phone))
    order_items = params.require(:order).permit(:order_items => [:product_id, :quantity])
    order_items['order_items'].each do |order_item|
      order.order_items.create(order_item)
    end
    @user.orders << order
    head 201, location: user_order_path(@user, order)
  end

  def payment
    @order.create_payment(params.require(:payment).permit(:amount, :pay_type))
    head 201
  end

  private
  def get_order
    @order = Order.find(params[:id].to_i)
  end

  private
  def get_user
    @user = User.find(params[:user_id].to_i)
  end

  private
    def not_found
      head 404
    end
end
