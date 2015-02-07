class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.string :position
      t.string :date
      t.boolean :fulltime
      t.references :resume, index: true

      t.timestamps
    end
  end
end
