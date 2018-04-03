require "rails_helper"

describe Api::V1::ProductScraperService, type: :stub_request do
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
end