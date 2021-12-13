class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.string :detail
      t.string :image
      t.float :price
      t.float :rating

      t.timestamps
    end
  end
end
