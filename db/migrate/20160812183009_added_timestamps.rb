class AddedTimestamps < ActiveRecord::Migration
  def change
    change_table :listings do |t|
      t.timestamps
    end
  end
end
