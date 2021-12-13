class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.boolean :is_default
      t.string :phone

      t.timestamps
    end
  end
end
