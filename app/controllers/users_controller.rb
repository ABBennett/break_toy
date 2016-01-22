class UsersController < ApplicationController
  # before_filter :authenticate_user!

  def index
    if user_signed_in?
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @conversation = Conversation.new
    else
      @users = User.all
      @conversation = Conversation.new
    end
  end

  def show
    @user = User.find(params[:id])
    @ratings = Rating.where(ratee_id: params[:id])
    @rates = Rating.where(rater_id: params[:id])

    @average_score = average_score(@user)
    @average_rate = average_rate(@user)
  end


  def average_score(user)
    if !@ratings.empty?
      sum = 0
      @ratings.each do |rating|
        sum += rating.score
      end
      average = (sum/@ratings.count.to_f).round(2)
    else
      "N/A"
    end
  end

  def average_rate(user)
    if !@rates.empty?
      sum = 0
      @rates.each do |rating|
        sum += rating.score
      end
      average = (sum/@rates.count.to_f).round(2)
    else
      "N/A"
    end
  end

end
