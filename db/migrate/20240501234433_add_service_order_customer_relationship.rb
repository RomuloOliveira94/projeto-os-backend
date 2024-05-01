class AddServiceOrderCustomerRelationship < ActiveRecord::Migration[7.1]
  def change
    add_reference :service_orders, :customer, null: false, foreign_key: true
  end
end
