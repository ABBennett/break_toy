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
  end
end
