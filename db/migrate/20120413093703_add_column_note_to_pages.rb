class AddColumnNoteToPages < ActiveRecord::Migration
  def change
    add_column :pages, :note, :text
  end
end
