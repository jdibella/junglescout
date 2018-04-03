require "rails_helper"

RSpec.describe Api::V1::InfoController, type: :controller do
  context "when asin provided" do
    let(:asin) { "SOMETHING" }
    before { stub_product_request(asin) }
    it "response with success" do
      get :show, params: { id: asin, page: 1 }
      expect(response.status).to eq 200
    end

    it "saves a sraped product" do
      expect do
        get :show, params: { id: asin, page: 1 }
      end.to change(Product, :count).by(1)
    end
  end
end