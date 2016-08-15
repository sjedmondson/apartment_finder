class AddImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :listing
      t.string :image
    end
  end
end
