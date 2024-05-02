FactoryBot.define do
  factory :customer do
    id {Faker::Number.number(digits: 5)}
    name {Faker::Name.name}
    phone {Faker::PhoneNumber.cell_phone}
    email {Faker::Internet.email}
    address {Faker::Address.street_address}
    address_number {Faker::Address.building_number}
    address_complement {Faker::Address.secondary_address}
    neighborhood {Faker::Address.community}
    city {Faker::Address.city}
    state {Faker::Address.state_abbr}
    zip_code {Faker::Address.zip_code}
    cpf_cnpj {Faker::Company.brazilian_company_number}
  end
end
