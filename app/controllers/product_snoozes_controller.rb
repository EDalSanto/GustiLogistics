class ProductSnoozesController < ApplicationController
  before_action :logged_in_user

  def create
    product = Product.find(params[:product_id])
    ProductSnooze.start_for(product: product)
  end

  def update
    product = Product.find(params[:product_id])
    ProductSnooze.end_for(product: product)
  end
end
