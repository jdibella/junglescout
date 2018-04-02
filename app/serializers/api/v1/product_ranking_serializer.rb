module Api::V1
  class ProductRankingSerializer < ActiveModel::Serializer
    attributes :rank, :category

    belongs_to :product
  end
end
