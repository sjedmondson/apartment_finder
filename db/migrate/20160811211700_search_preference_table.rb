class SearchPreferenceTable < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user
      t.integer :max_price, null: true
      t.integer :min_area, null: true
      t.integer :min_bedrooms, null: true
      t.integer :min_bathrooms, null: true
    end
  end
end
