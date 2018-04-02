FactoryBot.define do
  factory :product_review do
    rating { Faker::Number.decimal(1,2) }
    author { Faker::Name.name }
    body { Faker::Lorem.paragraph(2) }

    product
  end
end