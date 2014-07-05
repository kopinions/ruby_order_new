class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def show
    @product = Product.find(params[:id].to_i)
  end

  def create
    head 201
  end
  private
    def not_found
      head 404
    end
end
