class ProductSnooze < ApplicationRecord
  validates :product_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
