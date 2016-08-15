class ChangeUserTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :average_rating
    end
  end
end
