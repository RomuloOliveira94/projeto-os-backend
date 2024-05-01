class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :cnpj
      t.string :address
      t.string :neighborhood
      t.string :phone
      t.string :email
      t.string :logo
      t.string :state
      t.string :city
      t.string :zip_code
      t.integer :status, default: 0
      t.integer :business, default: 0
      t.string :payment_methods, array: true, default: []
      t.text :os_rules
      t.text :budget_rules
      t.timestamps
    end
  end
end
