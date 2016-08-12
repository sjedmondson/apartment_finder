class SearchPreferenceTable < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user
      t.integer :max_price, default:100000
      t.integer :min_area, default:0
      t.integer :min_bedrooms, default:0
      t.integer :min_bathrooms, default:0
    end
  end
end
