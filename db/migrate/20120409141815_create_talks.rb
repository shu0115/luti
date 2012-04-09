class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
