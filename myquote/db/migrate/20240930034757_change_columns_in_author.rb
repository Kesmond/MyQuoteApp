class ChangeColumnsInAuthor < ActiveRecord::Migration[7.0]
  def change
    change_column :authors, :biography, :text
  end
end
