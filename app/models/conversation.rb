class Conversation < ActiveRecord::Base
  paginates_per 20
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :ratings
  has_many :messages, dependent: :destroy

  scope :involving, -> (user) do
    where("conversations.sender_id =? OR conversations.recipient_id =?",user.id,user.id)
  end

  def includes?(user)
    sender == user || recipient == user
  end

  def self.chattiest
    select("conversations.*, COALESCE(COUNT(messages.id), 0) AS message_count")
    .joins("LEFT JOIN messages ON messages.conversation_id = conversations.id")
    .group("conversations.id")
    .order("message_count DESC")
  end

end
