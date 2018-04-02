module Api::V1
  class ProductReviewSerializer < ActiveModel::Serializer
    attributes :rating, :author, :body
  end
end
