class ProductController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def show
    @product = Product.find(params[:id].to_i)
  end

  private
    def not_found
      head 404
    end
end
