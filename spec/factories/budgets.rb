FactoryBot.define do
  factory :budget do
    id { 1 }
    customer_name { Faker::Name.name }
    customer_phone { Faker::PhoneNumber.cell_phone }
    services {[
      { name: "service 1", details: "service 1 details", price: Faker::Commerce.price },
      { name: "service 2", details: "service 2 details", price: Faker::Commerce.price },
      { name: "service 3", details: "service 3 details", price: Faker::Commerce.price }
    ]}
    products {[
      { name: Faker::Commerce.product_name, details: Faker::Commerce.product_name },
      { name: Faker::Commerce.product_name, details: Faker::Commerce.product_name }
    ]}
    materials {[
      { name: "material 1", price: Faker::Commerce.price },
      { name: "material 2", price: Faker::Commerce.price },
    ]}
    observations { Faker::Lorem.paragraph }
    subtotal { Faker::Commerce.price }
    discount { Faker::Commerce.price }
    total { subtotal - discount }
  end
end
