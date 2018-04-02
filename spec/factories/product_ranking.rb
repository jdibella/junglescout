FactoryBot.define do
  factory :product_ranking do
    rank { Faker::Number.between(1,100000) }
    category { Faker::Commerce.department }

    product
  end
end