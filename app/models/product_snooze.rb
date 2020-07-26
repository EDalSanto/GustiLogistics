class ProductSnooze < ApplicationRecord
  validates :product_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  belongs_to :product

  def self.start_for(product:)
    create!(
      product: product,
      start_date: Time.now,
      end_date: Time.now + 1.month
    )
  end

  def self.end_for(product:)
    update(end_date: Time.now)
  end
end
