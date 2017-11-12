class Api::V1::ProductsController < ApiController
  before_action :set_product

  def show
  end

  def index
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
