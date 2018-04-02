class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :asin
      t.timestamps
    end

    add_index :products, :asin, name: "idx_products_on_asin"
  end
end
