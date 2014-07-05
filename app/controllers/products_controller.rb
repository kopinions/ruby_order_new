class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def show
    @product = Product.find(params[:id].to_i)
  end

  def create
    product = Product.new(params.require('product').permit('name', 'description'))
    product.save
    head 201, location: product_path(product)
  end

  def index
    head 200
  end

  private
    def not_found
      head 404
    end
end
