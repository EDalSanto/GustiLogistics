class ProductsController < ApplicationController
  helper ProductsHelper
  before_action :product, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  def index
    @products = Product.search(params[:term]).paginate(page: params[:page])

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @first_half_top_customers = first_half_top_customers
    @second_half_top_customers = second_half_top_customers
  end

  def create
  end

  def update
    if product.update(product_params)
      product.update_reorder_date
      redirect_to(product, notice: 'Product was successfully updated.')
    else
      render action: 'edit'
    end
  end

  def destroy
  end

  private

    def product
      @product ||= Product.find(params[:id])
    end

    def product_params
      params.
        require(
          :product
        ).
          permit(
            :description,
            :current,
            :cover_time,
            :growth_factor,
            :lead_time,
            :travel_time,
            :cant_travel_start,
            :cant_travel_end,
            :cant_produce_start,
            :cant_produce_end,
            :enroute,
            :term
          )
    end
end
