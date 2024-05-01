class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.references :company, null: false, foreign_key: true
      t.string :customer_name
      t.string :customer_phone
      t.jsonb :services
      t.jsonb :products
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
