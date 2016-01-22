class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rater_id, null: false
      t.integer :ratee_id, null: false
      t.integer :conversation_id, null: false
      t.integer :score, null: false

      t.timestamps null: false
    end
    add_index :ratings, [:rater_id, :ratee_id, :conversation_id], unique: true
  end
end
