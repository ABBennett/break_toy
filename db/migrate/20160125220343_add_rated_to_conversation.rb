class AddRatedToConversation < ActiveRecord::Migration
  def change
    add_column(:conversations, :rated?, :boolean, default: false)
  end
end
