require 'test_helper'

class Api::V1::ProductLookupServiceTest < ActiveSupport::TestCase
  test "finds an existing product" do
    service = Api::V1::ProductLookupService.new("SOMECHEEZE")
    assert_equal service.find, products(:brie)
  end

  test "uses scraper to get product info when does not exist" do
    scraper = Minitest::Mock.new
    fake_product = Product.new({ title: "FOUND IT", asin: "DOESNOTEXIST"})
    scraper.expect :build_from_asin, fake_product, ["DOESNOTEXIST"]

    service = Api::V1::ProductLookupService.new("DOESNOTEXIST", scraper: scraper)
    assert_equal service.find, fake_product
  end
end