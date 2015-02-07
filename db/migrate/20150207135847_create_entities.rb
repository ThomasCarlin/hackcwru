class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
    	t.string :name
    	t.string :description
    	t.string :degree
    	t.string :major
    	t.string :position
    	t.string :website
      t.timestamps
    end
  end
end
