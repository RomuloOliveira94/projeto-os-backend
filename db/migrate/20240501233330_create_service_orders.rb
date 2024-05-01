class CreateServiceOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :service_orders do |t|
      t.references :company, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.jsonb :products
      t.jsonb :services
      t.jsonb :other_fees
      t.jsonb :materials
      t.text :observations
      t.float :subtotal
      t.float :discount
      t.float :total
      t.timestamps
    end
  end
end
