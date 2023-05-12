class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      
      t.integer :spot_id
      t.integer :customer_id
      t.string :title
      t.string :comment
      t.float :star
      
      t.timestamps
    end
  end
end
