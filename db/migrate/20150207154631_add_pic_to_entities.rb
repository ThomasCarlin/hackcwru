class AddPicToEntities < ActiveRecord::Migration
  def change
  	add_column :entities, :pic, :string
  end
end
