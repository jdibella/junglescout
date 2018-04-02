class Api::V1::ReviewsController < ApplicationController
  def index
    @asin = params[:info_id]
    @reviews = Api::V1::ReviewsLookupService.find(@asin, page: params[:page])

     # Again, this has the possibility of being extracted into a background persistence service,
     # or have the persistence service called inline from the controller.
    persist_reviews!

    render json: @reviews
  end

  private

  def persist_reviews!
    return if @reviews.blank?
    return if @reviews.first.persisted? # check the first one as a proxy for all

    product = Api::V1::ProductLookupService.find(@asin)

    @reviews.each { |review| product.product_reviews << review }
    product.save!
  end
end