require "rails_helper"

describe Api::V1::ProductScraperService do
  context "when scraping a product" do
    let(:asin) { "SOMETHING" }
    before { stub_product_request(asin) }
    subject { described_class.build_from_asin(asin) }

    it "returns a new product with extracted information" do
      expect(subject.title).to eq "Some Great Test Product"
      expect(subject.asin).to eq "SOMETHING"
      expect(subject.product_ranking.rank).to eq 5
      expect(subject.product_ranking.category).to eq "Baby"
    end
  end

  def stub_product_request(asin)
    stub_request(:get, "https://www.amazon.com/dp/#{asin}").
     with(  headers: {
      "Accept"=>"*/*",
      "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "User-Agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36"
       }).
     to_return(status: 200, body: fake_response("product"), headers: {})
  end

  private

  def fake_response(filename)
    File.open(Rails.root.join("spec", "support", "responses", filename), "rb").read
  end
end