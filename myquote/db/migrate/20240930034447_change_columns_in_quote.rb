class ChangeColumnsInQuote < ActiveRecord::Migration[7.0]
  def change
    change_column :quotes, :text, :text
    change_column :quotes, :comment, :text
  end
end
