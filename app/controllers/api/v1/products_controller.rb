class Api::V1::ProductsController < ApiController
  before_action :set_product

  def show
    render json: @product
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
