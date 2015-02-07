class Addusertoresume < ActiveRecord::Migration
  def change
  	add_column :resumes, :userid,:integer
  end
end
