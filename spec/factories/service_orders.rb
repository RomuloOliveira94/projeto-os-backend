FactoryBot.define do
  factory :service_order do
    id {Faker::Number.number(digits: 5)}
    services {[
      { name: "service 1", details: "service 1 details", price: Faker::Commerce.price },
      { name: "service 2", details: "service 2 details", price: Faker::Commerce.price },
      { name: "service 3", details: "service 3 details", price: Faker::Commerce.price }
    ]}
    start_date {Faker::Date.between(from: 2.days.ago, to: Date.today) }
    end_date {Faker::Date.between(from: Date.today, to: 2.days.from_now) }
    products {[{ name: Faker::Commerce.product_name, details: Faker::Commerce.product_name },{ name: Faker::Commerce.product_name, details: Faker::Commerce.product_name }]}
    materials {[
      { name: "material 1", price: Faker::Commerce.price },
      { name: "material 2", price: Faker::Commerce.price },
      { name: "material 3", price: Faker::Commerce.price }
    ]}
    observations {Faker::Lorem.paragraph}
    subtotal {Faker::Commerce.price}
    discount {Faker::Commerce.price}
    total {subtotal - discount}
    created_at {Faker::Date.between(from: 2.days.ago, to: Date.today) }
    updated_at {Faker::Date.between(from: Date.today, to: 2.days.from_now) }
  end
end
