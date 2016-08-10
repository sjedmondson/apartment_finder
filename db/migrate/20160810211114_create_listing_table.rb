class CreateListingTable < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :price
      t.integer :area
      t.string :url,
        uniqueness: true
    end
  end
end
