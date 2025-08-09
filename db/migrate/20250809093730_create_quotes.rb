class CreateQuotes < ActiveRecord::Migration[8.0]
  def change
    create_table :quotes do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content, null: false
      t.string :quote_type, null: false, limit: 20
      t.integer :views_count, default: 0, null: false
      t.integer :likes_count, default: 0, null: false
      t.integer :dislikes_count, default: 0, null: false

      t.timestamps
    end
    
    add_index :quotes, :quote_type
    add_index :quotes, :created_at
    add_index :quotes, [:user_id, :created_at]
  end
end
