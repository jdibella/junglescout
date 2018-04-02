module Api::V1
  class ProductSerializer < ActiveModel::Serializer
    attributes :title, :asin

    has_one :product_ranking
  end
end
