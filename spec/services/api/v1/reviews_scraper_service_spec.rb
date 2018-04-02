require "rails_helper"

describe Api::V1::ReviewsScraperService do
  context "when scraping product reviews" do
    let(:asin) { "SOMETHING" }
    let(:page) { 1 }
    before { stub_reviews_request(asin, page: page) }
    subject { described_class.build_from_asin(asin, page: page) }


    it "returns new reviews with extracted information" do
      expect(subject.length).to eq 10
      expect(subject.first.author).to eq "Danielle"
      expect(subject.first.rating.to_f).to eq 5.0
      expect(subject.first.body).to_not be_nil
    end
  end

  def stub_reviews_request(asin, page:)
    stub_request(:get, "https://www.amazon.com/product-reviews/#{asin}?reviewerType=all_reviews&pageNumber=#{page}").
     with(  headers: {
      "Accept"=>"*/*",
      "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "User-Agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36"
       }).
     to_return(status: 200, body: fake_response("reviews"), headers: {})
  end

  private

  def fake_response(filename)
    File.open(Rails.root.join("spec", "support", "responses", filename), "rb").read
  end
end