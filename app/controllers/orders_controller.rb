class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :get_user


  def show
    order_find = Order.find(params[:id].to_i)
    head 200
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
