require "rails_helper"

RSpec.describe Api::V1::ReviewsController, type: :controller do
  context "when asin provided" do
    let(:asin) { "SOMETHING" }
    let(:page) { 1 }
    before do
      stub_reviews_request(asin, page: page)
      stub_product_request(asin)
    end
    it "response with success" do
      get :index, params: { info_id: asin, page: page }
      expect(response.status).to eq 200
    end

    it "saves scraped reviews" do
      expect do
        get :index, params: { info_id: asin, page: page }
      end.to change(ProductReview, :count).by(10)
    end
  end
end