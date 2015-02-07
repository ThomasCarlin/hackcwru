class CreateEntityResumes < ActiveRecord::Migration
  def change
    create_table :entity_resumes do |t|
    	t.integer :resumeid
    	t.integer :entityid

      t.timestamps
    end
  end
end
