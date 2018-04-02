FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    asin  { Faker::Internet.password(10).upcase }

    trait :with_ranking do
      transient do
        rank 10
        category "Something"
      end
      after(:build) do |_product, evaluator|
        build(
          :product_ranking,
          product: _product,
          rank: evaluator.rank,
          category: evaluator.category
        )
      end
    end
  end
end