class CreateProductRankings < ActiveRecord::Migration[5.1]
  def change
    create_table :product_rankings do |t|
      t.integer :rank
      t.integer :product_id
      t.string :category

      t.timestamps
    end

    add_foreign_key :product_rankings, :products
  end
end
