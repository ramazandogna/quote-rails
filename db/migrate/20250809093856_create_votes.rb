class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :quote, null: false, foreign_key: true
      t.string :vote_type, null: false, limit: 10
      t.string :ip_address, null: false, limit: 45

      t.timestamps
    end
    
    add_index :votes, [:quote_id, :ip_address], unique: true
    add_index :votes, :vote_type
  end
end
