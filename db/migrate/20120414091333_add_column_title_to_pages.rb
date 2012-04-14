class AddColumnTitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :title, :string
  end
end
