require 'rails_helper'

RSpec.describe Product, type: :model do
  context "validations" do
    subject { product.valid? }
    context "asin uniqueness" do
      let(:existing_product) { create :product }
      let(:product) { build :product, asin: existing_product.asin }
      it{ is_expected.to eq false }

      it "adds uniqueness errors to the model" do
        product.valid?
        expect(product.errors.added?(:asin, :taken)).to be true
      end
    end
  end
end
