class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.string :text, null: false
      t.integer :year_publication, null: true
      t.string :comment, null: true
      t.boolean :is_public, null: false
      t.references :author, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
