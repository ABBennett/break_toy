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

    @new_messages = unanswered
  end

  def all_unrated_conversations(user)
    b = Conversation.where(
          Conversation.where(conversations: {recipient_id: user.id})
          .where(conversations: {sender_id: user.id})
          .where_values.reduce(:or))
          .where(conversations: {rated?: false})
  end

  def unanswered
    unanswered = []
    all_unrated_conversations(@user).each do |conversation|
      if !conversation.messages.empty? && conversation.messages.last.user != @user
        unanswered << conversation
      end
    end
    unanswered
  end

end
