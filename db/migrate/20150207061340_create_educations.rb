class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school
      t.string :schoolcode
      t.string :city
      t.string :state
      t.string :degreetype
      t.string :degree
      t.string :graddate
      t.string :mgpa
      t.string :gpa
      t.references :resume, index: true
      t.timestamps
    end
  end
end
