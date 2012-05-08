class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    
    add_index :relationships, :parent_id
    add_index :relationships, :child_id
  end
end
