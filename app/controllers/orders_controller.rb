class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    order_find = Order.find(params[:id].to_i)
    head 200
  end

  private
    def not_found
      head 404
    end
end
