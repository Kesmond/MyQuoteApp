class ChangeColumnsInUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :password_digest, :string
  end
end
