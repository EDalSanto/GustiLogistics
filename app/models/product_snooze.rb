class ProductSnooze < ApplicationRecord
  validates :product_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :no_other_active_snoozes_for_product, on: :create

  belongs_to :product

  scope :active, -> { where("end_date > NOW()") }
  scope :for_product, ->(product) { where(product: product) }

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

  private

  def no_other_active_snoozes_for_product
    if ProductSnooze.active.for_product(product).exists?
      errors.add(:product, "active snooze already exists for this product")
    end
  end
end
