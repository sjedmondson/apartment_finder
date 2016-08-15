class AddComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :rating
      t.belongs_to :user
      t.belongs_to :listing
    end
  end
end
