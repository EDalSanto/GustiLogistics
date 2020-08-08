require 'test_helper'

class ProductSnoozeTest < ActiveSupport::TestCase
  test '.end_for marks a product snooze as no longer active' do
    # Snooze setup
    product = Product.first
    product_snooze = ProductSnooze.start_for(product: product)
    assert(product.product_snooze)
    assert(product_snooze.active?)

    # Remove snooze
    ProductSnooze.end_for(product: product)
    refute(product.reload.product_snooze)
    refute(product_snooze.reload.active?)
  end

  test '.end_for works with multiple products' do
    # Snooze setup
    products = Product.all.map do |product|
      product_snooze = ProductSnooze.start_for(product: product)
      assert(product.product_snooze)

      product
    end

    # Remove snooze for one
    ProductSnooze.end_for(product: products[0])
    refute(products[0].reload.product_snooze)

    # Assert still on rest
    products[1..-1].each do |product|
      assert(product.product_snooze)
    end
  end

  test '.end_for works for multiple snoozes of same product' do
    # Snooze setup
    product = Product.first
    product_snooze = ProductSnooze.start_for(product: product)
    assert(product.product_snooze)
    assert(product_snooze.active?)

    # Remove snooze
    ProductSnooze.end_for(product: product)
    refute(product.reload.product_snooze)
    refute(product_snooze.reload.active?)

    # Add back
    product = Product.first
    product_snooze = ProductSnooze.start_for(product: product)
    assert(product.product_snooze)
    assert(product_snooze.active?)

    # Remove snooze
    ProductSnooze.end_for(product: product)
    refute(product.reload.product_snooze)
    refute(product_snooze.reload.active?)
  end
end
