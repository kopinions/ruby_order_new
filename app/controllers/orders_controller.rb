class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :get_user


  def show
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
