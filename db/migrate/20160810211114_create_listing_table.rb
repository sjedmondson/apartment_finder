class CreateListingTable < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :price
      t.integer :area
      t.float :latitude
      t.float :longitude
      t.string :street_address
    end
  end
end
