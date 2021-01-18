class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :trip_name
      t.string :length
      t.string :weather
      t.integer :weight
      t.string :image_url
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
