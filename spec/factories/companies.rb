FactoryBot.define do
  factory :company do
    user {create(:user)}
    name {Faker::Company.name}
    cnpj {Faker::Company.brazilian_company_number}
    address {Faker::Address.street_address}
    neighborhood {Faker::Address.community}
    phone {Faker::PhoneNumber.cell_phone}
    email {Faker::Internet.email}
    state {Faker::Address.state}
    city {Faker::Address.city}
    zip_code {Faker::Address.zip_code}
    status {0}
    business {0}
  end
end
