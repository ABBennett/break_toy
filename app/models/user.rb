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

  def convo_count
    Conversation.where(
                Conversation.where(conversations: {recipient_id: self.id})
                .where(conversations: {sender_id: self.id})
                .where_values.reduce(:or))
                .count
  end

  def message_count
    Message.where(user_id: self.id).count
  end

  def score_color
    if self.average_score == 10.0
      "ten"
    elsif self.average_score >= 9.5
      "nine-5"
    elsif self.average_score >= 9.0
      "nine"
    elsif self.average_score >= 8.5
      "eight-5"
    elsif self.average_score >= 8.0
      "eight"
    elsif self.average_score >= 7.5
      "seven-5"
    elsif self.average_score >= 7.0
      "seven"
    elsif self.average_score >= 6.5
      "six-5"
    elsif self.average_score >= 6.0
      "six"
    elsif self.average_score >= 5.5
      "five-5"
    elsif self.average_score >= 5.0
      "five"
    elsif self.average_score >= 4.5
      "four-5"
    elsif self.average_score >= 4.0
      "four"
    elsif self.average_score >= 3.5
      "three-5"
    elsif self.average_score >= 3.0
      "three"
    elsif self.average_score >= 2.5
      "two-5"
    elsif self.average_score >= 2.0
      "two"
    elsif self.average_score >= 1.5
      "one-5"
    elsif self.average_score >= 1.0
      "one"
    elsif self.average_score >= 0.5
      "zero-5"
    else
      "zero"
    end
  end

  def in_conversation?(conversation)
    self == conversation.sender || self == conversation.recipient
  end
end
