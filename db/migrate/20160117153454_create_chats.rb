class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :title, null: false
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false
      t.boolean :archive, null: false, default: false;

      t.timestamps null: false
    end
  end
end
