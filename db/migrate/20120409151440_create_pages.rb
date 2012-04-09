class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.integer :talk_id
      t.integer :number
      t.text :contents

      t.timestamps
    end
  end
end
