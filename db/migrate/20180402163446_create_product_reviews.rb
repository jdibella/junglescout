class CreateProductReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :product_reviews do |t|
      t.integer :product_id
      t.numeric :rating, precision: 2, scale: 1
      t.string :author
      t.text :body

      t.timestamps
    end

    add_foreign_key :product_reviews, :products
  end
end
