class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
    	t.string :company
      t.string :position
      t.string :datestart
      t.string :dateend
      t.references :resume, index: true

      t.timestamps
    end
  end
end
