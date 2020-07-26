class CreateProductSnoozes < ActiveRecord::Migration[5.1]
  def change
    create_table :product_snoozes do |t|
      t.integer :product_id, null: false
      # start date largely for paper trail
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end

    # We'll join by prouct id and then filter by end_date
    add_index :product_snoozes, [:product_id, :end_date]
  end
end
