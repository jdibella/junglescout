module Api::V1
  class ProductLookupService

    def self.find(asin)
      new(asin).find
    end

    def initialize(asin, scraper: Api::V1::ProductScraperService)
      @asin = asin
      @scraper = scraper
      raise ActiveRecord::RecordNotFound if @asin.blank?
    end

    def find
      Product.find_by(asin: @asin) || @scraper.build_from_asin(@asin)
    end
  end
end