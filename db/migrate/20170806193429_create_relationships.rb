class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :connection_id
      t.integer :status_id
      t.string :connected_status
      t.integer :step_id
      t.string :step_status

      t.timestamps
    end
  end
end
