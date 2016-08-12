class AssociatedUserAndListing < ActiveRecord::Migration
  def change
    change_table :listings do |t|
      t.belongs_to :user
    end
  end
end
