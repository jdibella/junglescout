module Api::V1
  class ReviewsLookupService

    def self.find(asin, page: 1)
      new(asin, page: page).find
    end

    def initialize(asin, page: 1, scraper: Api::V1::ReviewsScraperService)
      @asin = asin
      @page = page
      @scraper = scraper
      raise ActiveRecord::RecordNotFound if @asin.blank?
    end

    def find
      reviews = ProductReview.joins(:product)
        .where(products: {asin: @asin})
        .limit(10) # based on scrape amazon product reviews count
        .offset((@page.to_i - 1) * 10)

      return @scraper.build_from_asin(@asin, page: @page) if reviews.blank?

      reviews
    end
  end
end