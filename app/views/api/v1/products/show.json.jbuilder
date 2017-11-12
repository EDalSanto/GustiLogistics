json.id @product.id
json.gusti_id @product.gusti_id
json.current_status do
  json.quantity @product.current
  json.calculated_next_reorder_date @product.next_reorder_date
  json.enroute @product.enroute
end
json.settings do
  json.lead_time @product.lead_time
  json.cover_time @product.cover_time
  json.growth_factor @product.growth_factor
end

