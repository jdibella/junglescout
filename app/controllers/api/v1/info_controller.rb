class Api::V1::InfoController < ApplicationController
  def show
    asin = params[:id]
    @product = Api::V1::ProductLookupService.find(asin)

    # Options for peristence:
    #  1. Always lookup scraped product info and compare against persisted object,
    #     updating persisted object if necessary
    #  2. Persist scraped object on first run
    #    a. and delegate saving to background persistence job
    #       ex: `ProductPersistenceJob.perform_later(@product)`
    #    b. and persist the object inline in the controller action
    #
    # I'm going to use option 2b, as it provides the simplest implemenation
    # in the absence of any definitive requirements.
    @product.save! if @product.new_record?

    render json: @product
  end
end