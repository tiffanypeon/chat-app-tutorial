class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :topic
      t.integer :owner_id

      t.timestamps
    end
  end
end
