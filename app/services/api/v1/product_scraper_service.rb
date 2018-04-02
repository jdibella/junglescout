module Api::V1
  class ProductScraperService

    def self.build_from_asin(asin)
      new(asin).build_product
    end

    def initialize(asin)
      @asin = asin
    end

    def build_product
      require "open-uri"

      doc = Nokogiri::HTML(
        open(
          "https://www.amazon.com/dp/#{@asin}",
          ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE,
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
        )
      )

      rankingMatch = doc.css("#SalesRank > .value")
        .text
        .strip
        .match(/\#(\d+,?+) in (.*) \(/)
        # ex: matches on "#5,000 in Baby (" and captures "5,000" and "Baby"
      product = Product.new({
        title: doc.css('#title > span')[0].text.strip,
        asin: @asin,
      })
      product.build_product_ranking(ranking_attrs(rankingMatch)) if rankingMatch
      product
    end

    private

    def ranking_attrs(matchData)
      {
        rank: matchData.captures.first.to_i,
        category: matchData.captures.second
      }
    end
  end
end