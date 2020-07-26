class ProductSnoozesController < ApplicationController
  before_action :logged_in_user

  def create
    product = Product.find(params[:product_snooze][:product_id])
    ProductSnooze.start_for(product: product)

    redirect_back(fallback_location: root_path, notice: 'Product snoozed.')
  end

  def update
    product = Product.find(params[:product_snooze][:product_id])
    ProductSnooze.end_for(product: product)

    redirect_back(fallback_location: root_path, notice: 'Product unsnoozed.')
  end

  private

  def product_snooze_params
    params.require(:product_snooze).permit(:product_id)
  end
end
