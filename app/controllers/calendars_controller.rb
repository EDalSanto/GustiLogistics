class CalendarsController < ApplicationController
  def index
    @products = Product.select_setup_products.includes(:product_snooze).reject(&:product_snooze)

    update_overdue_unordered_products

    @products_by_reorder_date = @products.group_by(&:next_reorder_date)

    # Defaults to today's date to use this month
    # Date parameter changed by clicking arrow in view
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  private

    def update_overdue_unordered_products
      @products.each do |product|
        unless product.enroute || product.next_reorder_date > Date.today
          product.update_attribute(:next_reorder_date, Date.today)
        end
      end
    end
end
