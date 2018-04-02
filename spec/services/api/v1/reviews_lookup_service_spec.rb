require "rails_helper"

describe Api::V1::ReviewsLookupService do
  context "when searching for db reviews" do
    subject { described_class.new(asin).find.to_a }
    let(:review) { create :product_review }
    let(:asin) { review.product.asin }

    it { is_expected.to eq [review] }
  end

  context "when searching for a non-db product" do
    let(:asin) { "SOMETHING" }
    let(:scraper) { double("scraper") }
    let(:review) { build(:product_review) }
    let(:service) { Api::V1::ReviewsLookupService.new(asin, scraper: scraper) }
    before { allow(scraper).to receive_messages(build_from_asin: [review]) }

    it "uses scraper to return a product" do
      assert_equal service.find.to_a, [review]
    end
  end
end