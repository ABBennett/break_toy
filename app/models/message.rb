class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  has_many :ratings, through: :conversation

  validates_presence_of :body, :conversation_id, :user_id
  attr_accessor :use_self_class

  def sent_by?(signed_in_user)
    if signed_in_user && conversation.includes?(signed_in_user)
      user == signed_in_user ? "self" : "other"
    else
      conversation.sender == user ? "self" : "other"
    end
  end
end
