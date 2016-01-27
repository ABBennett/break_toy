class User < ActiveRecord::Base
  has_many :conversations
  has_many :ratings
  has_many :messages, through: :conversation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def average_score
    ratings = Rating.where(ratee: self)
    if !ratings.empty?
      sum = 0
      ratings.each do |rating|
        sum += rating.score
      end
      (sum / ratings.count.to_f).round(1)
    else
      0
    end
  end

  def average_rate
    ratings = Rating.where(rater: self)
    if !ratings.empty?
      sum = 0
      ratings.each do |rating|
        sum += rating.score
      end
      (sum / ratings.count.to_f).round(1)
    else
      0
    end
  end

  def total
    ratings = Rating.where(ratee: self)
    if !ratings.empty?
      sum = 0
      ratings.each do |rating|
        sum += rating.score
      end
      sum
    else
      0
    end
  end

  def total_rates
    ratings = Rating.where(rater: self)
    if !ratings.empty?
      sum = 0
      ratings.each do |rating|
        sum += rating.score
      end
      sum
    else
      0
    end
  end

  def tens
    ratings = Rating.where(ratee: self)
    if !ratings.empty?
      sum = 0
      ratings.each do |rating|
        if rating.score == 10
          sum += 1
        end
      end
      sum
    else
      0
    end
  end

  # def messages_count 
  #   sum = 0
  #   conversations = Conversation.where(
  #         Conversation.where(conversations: {recipient_id: user.id})
  #         .where(conversations: {sender_id: user.id})
  #         .where_values.reduce(:or))
  #   conversations.each do |c|
  #     c.messages

end
