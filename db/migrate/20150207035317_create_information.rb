class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.references :resume, index: true

      t.timestamps
    end
  end
end
