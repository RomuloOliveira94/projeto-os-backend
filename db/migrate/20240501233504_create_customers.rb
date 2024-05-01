class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.string :cpf_cnpj
      t.string :email
      t.string :phone
      t.string :address
      t.string :address_number
      t.string :address_complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code
      t.timestamps
    end
  end
end
