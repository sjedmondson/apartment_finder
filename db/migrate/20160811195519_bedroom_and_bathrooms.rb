class BedroomAndBathrooms < ActiveRecord::Migration
  def change
    change_table :listings do |t|
      t.integer :bathrooms
      t.integer :bedrooms
    end
  end
end
