require "rails_helper"

describe Api::V1::ReviewsScraperService, type: :stub_request do
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
end