class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer :genre_id
      t.integer :prefecture_id
      t.string :name
      t.text :introduction
      t.string :address

      t.timestamps
    end
  end
end
