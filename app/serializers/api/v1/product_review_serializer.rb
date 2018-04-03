module Api::V1
  class ProductReviewSerializer < ActiveModel::Serializer
    attributes :id, :rating, :author, :body
  end
end
