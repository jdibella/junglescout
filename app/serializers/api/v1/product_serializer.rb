module Api::V1
  class ProductSerializer < ActiveModel::Serializer
    attributes :id, :title, :asin

    has_one :product_ranking
  end
end
