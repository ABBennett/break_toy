class UsersController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @conversation = Conversation.new
    if params[:order] == "average"
      @users = User.all.sort{ |b,a| a.average_score <=> b.average_score }
      @memo = "Classiest: This ranks users by average talking points"
    elsif params[:order] == "averagedesc"
      @users = User.all.sort{ |a,b| a.average_score <=> b.average_score }
        @memo = "Trashiest: This ranks users by average talking points in reverse"
    elsif params[:order] == "messagecount"
        @users = User.all.sort{ |b,a| a.message_count <=> b.message_count}
        @memo = "Chattiest: This ranks users by the number of messages they've sent"
    elsif params[:order] == "messagecountdesc"
        @users = User.all.sort{ |a,b| a.message_count <=> b.message_count}
        @memo = "Quietest: This ranks users by the number of messages they've sent in reverse"
    elsif params[:order] == "ttlpts"
      @users = User.all.sort{ |b,a| a.total <=> b.total }
        @memo = "Pointiest: This ranks users by their total accumulated talking points"
    elsif params[:order] == "totaldesc"
      @users = User.all.sort{ |a,b| a.total <=> b.total }
        @memo = "Flatest: This ranks users in reverse order by their total accumulated talking points"
    else
      if user_signed_in?
        @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      else
        @users = User.all
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @ratings = Rating.where(ratee_id: params[:id])
    @rates = Rating.where(rater_id: params[:id])

    @new_messages = unanswered

    @rated_convos = all_rated_conversations(@user).order("created_at DESC")
  end

  def all_unrated_conversations(user)
    b = Conversation.where(
          Conversation.where(conversations: {recipient_id: user.id})
          .where(conversations: {sender_id: user.id})
          .where_values.reduce(:or))
          .where(conversations: {rated?: false})
  end

  def all_rated_conversations(user)
    b = Conversation.where(
          Conversation.where(conversations: {recipient_id: user.id})
          .where(conversations: {sender_id: user.id})
          .where_values.reduce(:or))
          .where(conversations: {rated?: true})
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
