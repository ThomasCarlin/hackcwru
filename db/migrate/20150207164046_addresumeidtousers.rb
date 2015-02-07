class Addresumeidtousers < ActiveRecord::Migration
  def change
  	add_column :users, :resumeid,:integer
  	add_column :users, :entityid, :integer
  end
end
