class Product < ApplicationRecord
  has_one :product_ranking, dependent: :destroy
  has_many :product_reviews
  # not `dependent: :destroy` because I think the reviews should really be
  # dependant on their author being destroyed to be removed

  validates :asin, uniqueness: true
end
