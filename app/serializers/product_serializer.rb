class ProductSerializer < ActiveModel::Serializer
  attributes :id,
             :gusti_id,
             :current

  def current
    {
      quantity: object.current,
      next_calculated_reorder_date: object.next_reorder_date
    }
  end
end
