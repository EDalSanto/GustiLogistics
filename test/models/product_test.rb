require 'test_helper'

include Dateable

describe Product, 'gusti_id' do

  before do
    @product = products(:faella_spaghetti)
  end

  it 'should be unique' do
    duplicate_product = @product.dup
    duplicate_product.gusti_id.downcase!

    duplicate_product.wont_be :valid?
  end
end

describe Product, '.select_setup_products' do

  before do
    @setup_products = Product.select_setup_products
  end

  it 'detects if a product is setup with a next reorder date' do
    setup_product = products(:pianogrillo)
    @setup_products.include?(setup_product).must_equal true
  end

  it 'detects if a product is setup with a next reorder date' do
    not_setup_product = products(:not_setup)
    @setup_products.include?(not_setup_product).must_equal false
  end

end

describe Product, '.existing_gusti_id?' do

  before do
    @product = products(:faella_spaghetti)
  end

  it 'determines if a product exists by gusti id' do
    Product.existing_gusti_id?(@product.gusti_id).must_equal true
    Product.existing_gusti_id?('gustigusti').wont_equal true
  end
end

describe Product, '#actual_next_reorder_date' do

  before do
    @product = products(:faella_spaghetti)
    @blocked_product = products(:pianogrillo)
    @no_blocks_product = products(:no_blocks)
  end

  it "calculates reorder dates and accounts for different years" do
    @product.actual_next_reorder_date.year.must_equal (Date.today + 1.year).year
  end

  it "calculates next reorder date for before block interval" do
    @blocked_product.actual_next_reorder_date.yday.must_equal @blocked_product.send(:travel_block_start_yday) - 1
  end

  it "calculates next reorder date for product that just went out of inventory" do
    @blocked_product.current = 0

    @blocked_product.actual_next_reorder_date.must_equal Date.today
  end

  it "calculates next reorder date for produce block interval" do
    @blocked_product.cant_produce_start = Date.new(2017, 4, 28)
    last_day_to_order = @blocked_product.cant_produce_start - @blocked_product.lead_time.to_i.months

    @blocked_product.actual_next_reorder_date.must_equal last_day_to_order
  end

  it 'calculates reorder date for product with no blocks' do
    hand_calculated_date = Date.new(2017, 7, 9)
    @no_blocks_product.actual_next_reorder_date.must_be :===, hand_calculated_date
  end
end

describe Product, '#gap_days' do

  describe 'when reorder after next date in block interval' do
    before do
      @product = products(:pianogrillo)
      @hand_calculated_gap_days = 46
      @proposed_reorder_after_next_yday = @product.send(:naive_reorder_after_next_yday)
    end

    it 'finds number of days to cover inventory for travel block' do
      @product.send(:gap_days, @proposed_reorder_after_next_yday).must_equal @hand_calculated_gap_days
    end
  end

  describe "when a product doesn't have gap days" do
    before do
      @no_blocks_product = products(:no_blocks)
      @proposed_reorder_after_next_yday = @no_blocks_product.send(:naive_reorder_after_next_yday)
    end

    it "returns 0 for gap days" do
      @no_blocks_product.send(:gap_days, @proposed_reorder_after_next_yday).must_equal 0
    end
  end

end

describe Product, '#expected_quantity_on_date' do
  before do
    @product = products(:pianogrillo)
    @tomorrow = Date.today + 1.day
    @one_day_of_sales = 4
  end

  it 'calculated product quantity on future date' do
    @product.expected_quantity_on_date(@tomorrow).must_equal(@product.current - @one_day_of_sales)
  end

end

describe Product, '#naive_reorder_quantity' do
  before do
    @product = products(:faella_spaghetti)
    @blocked_product = products(:pianogrillo)
    @naive_full_order = 480
  end

  it 'calculates a naive full order quantity for no shipping blocks' do
    @product.current = 0
    d = Date.new(2017, 1, 1)

    Timecop.travel(d) do
      @product.send(:naive_reorder_quantity).must_equal @naive_full_order
    end
  end

  it 'calculates a naive full order quantity of less than normal full order for products that have to order sooner than expected because of shipping block' do
    @blocked_product.send(:naive_reorder_quantity).must_be :<, @naive_full_order
  end
end

describe Product, '#actual_reorder_quantity' do

  describe 'when calculating a quantity for a blocked product' do

    before do
      @product = products(:pianogrillo)
      naive_reorder_quantity = @product.send(:naive_reorder_quantity)
      cover_gap_days_quantity = @product.send(:cover_gap_days_quantity)
      @actual_reorder_quantity = naive_reorder_quantity + cover_gap_days_quantity
    end

    it 'finds correct quantity adjusting for gap days' do
      @product.actual_reorder_quantity.must_equal @actual_reorder_quantity
    end
  end

  describe 'when calculating a quantity for a product without blocks' do

    before do
      @no_blocks_product = products(:no_blocks)
      @naive_reorder_quantity = @no_blocks_product.send(:naive_reorder_quantity)
    end

    it 'finds naive reorder quantiy' do
      @no_blocks_product.actual_reorder_quantity.must_equal @naive_reorder_quantity
    end
  end
end

describe Product, '#find_top_customers_in_range' do
  before do
    product = products(:pianogrillo)
    start_date = Date.new(2016, 7, 1)
    final_date = Date.new(2016, 12, 1)
    tops = product.find_top_customers_in_range(start_date, final_date)
    @top = tops.keys.first
  end

  it 'finds top customers including retail in range' do
    @top.must_equal 'Retail'
  end
end

describe Product, '#next_product' do
  before do
    @product = products(:pianogrillo)
  end

  it 'finds the next product' do
    @product.next_product.must_equal products(:faella_spaghetti)
  end
end

describe Product, '#previous_product' do
  before do
    @product = products(:faella_spaghetti)
  end

  it 'finds the next product' do
    @product.previous_product.must_equal products(:pianogrillo)
  end
end
