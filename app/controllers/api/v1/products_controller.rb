class Api::V1::ProductsContoller < ApiController
  def show
    @product = Product.find(params[:id])
  end
end
