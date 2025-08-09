class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :quote, null: false, foreign_key: true
      t.text :content, null: false
      t.string :anonymous_name, limit: 50

      t.timestamps
    end
    
    add_index :comments, [:quote_id, :created_at]
  end
end
