module Api::V1
  class ReviewsScraperService

    def self.build_from_asin(asin, page: 1)
      new(asin: asin, page: page).build_reviews
    end

    def initialize(asin:, page: 1)
      @asin = asin
      @page = page
    end

    def build_reviews
      require "open-uri"
      doc = Nokogiri::HTML(
        open(
          "https://www.amazon.com/product-reviews/#{@asin}?reviewerType=all_reviews&pageNumber=#{@page}",
          ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
        )
      )
      reviews = doc.css(".reviews-content > .review-views > .a-section")
      reviews.map do |review|
        stars = review.css(".a-link-normal")[0]
          .text
          .strip
          .match(/(\d.?\d?) out of \d stars/)
          .captures.first.to_i

        author = review.css(".author").text.strip
        body   = review.css(".review-text").text.strip

        ProductReview.new(author: author, rating: stars, body: body)
      end
    end
  end
end