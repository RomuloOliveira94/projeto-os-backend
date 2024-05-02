FactoryBot.define do
  factory :user do
    id {Faker::Number.number(digits: 5)}
    email {Faker::Internet.email}
    name {Faker::Name.name}
    password {Faker::Internet.password}
  end
end
