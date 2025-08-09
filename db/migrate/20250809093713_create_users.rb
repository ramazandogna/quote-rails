class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 100
      t.string :last_name, null: false, limit: 100
      t.string :linkedin_url, limit: 500

      t.timestamps
    end
    
    add_index :users, [:first_name, :last_name]
  end
end
