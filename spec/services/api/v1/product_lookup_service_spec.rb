require "rails_helper"

describe Api::V1::ProductLookupService do
  context "when searching for db product" do
    subject { described_class.new(asin).find }
    let(:product) { create :product }
    let(:asin) { product.asin }

    it { is_expected.to eq product }
  end

  context "when searching for a non-db product" do
    let(:asin) { "SOMETHING" }
    let(:scraper) { double("scraper") }
    let(:product) { build(:product) }
    let(:service) { Api::V1::ProductLookupService.new(asin, scraper: scraper) }
    before { allow(scraper).to receive_messages(build_from_asin: product) }

    it "uses scraper to return a product" do
      assert_equal service.find, product
    end
  end
end