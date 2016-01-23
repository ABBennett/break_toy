class User < ActiveRecord::Base
  has_many :conversations
  has_many :ratings
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
      (sum / ratings.count.to_f).round(2)
    else
      "N/A"
    end
  end

  def average_rate
    ratings = Rating.where(rater: self)
    if !ratings.empty?
      sum = 0
      ratings.each do |rating|
        sum += rating.score
      end
      (sum / ratings.count.to_f).round(2)
    else
      "N/A"
    end
  end
end
