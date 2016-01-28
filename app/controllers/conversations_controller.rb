class ConversationsController < ApplicationController
  before_action :signed_in_flash, only: [:create]
  # before_action :participant?, only: [:show]

  def index
    if params[:order] == "totalpoints"
      @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.sender.average_score + a.recipient.average_score <=> b.sender.average_score + b.recipient.average_score }).page(params[:page]).per(10)
      @memo = "Classiest: This sorts by the classiest talk between the highest scored users"
    elsif params[:order] == "message"
        @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.messages.count <=> b.messages.count }).page(params[:page]).per(10)
        @memo = "Chattiest: This displays the chattiest talks first, in order of message count"
    elsif params[:order] == "points"
        @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.sender.total + a.recipient.total <=> b.sender.total + b.recipient.total }).page(params[:page]).per(10)
        @memo = "Pointiest: This sorts talks by cumulative Talking Points"
    elsif params[:order] == "sender"
      @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.sender.average_score || a.recipient.average_score <=> b.sender.average_score || b.recipient.average_score }).page(params[:page]).per(10)
      @memo = "Top Sender: This sorts talks by the highest scored sender"
    elsif params[:order] == "recipient"
        @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.recipient.average_score <=> b.recipient.average_score }).page(params[:page]).per(10)
        @memo = "Top Recipient: This sorts talks by the highest scored recipient"
    elsif params[:order] == "lopsided"
        @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| (a.recipient.average_score - a.sender.average_score).abs <=> (b.recipient.average_score - b.sender.average_score).abs }).page(params[:page]).per(10)
        @memo = "Lopsided: This sorts talks by the ones with the greatest difference between user's score"
    else
      @conversations = Conversation.all.order("created_at DESC").page(params[:page]).per(20)
      @memo = "Most Recent"
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @recipient_id = @conversation.recipient.id
    @sender_id = @conversation.sender.id

    @message = Message.new
    @messages = @conversation.messages.order("created_at")

    @rating = Rating.new

  end

  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.sender = current_user
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      redirect_to users_path
      flash[:alert] = 'You are unable to chat with this user'
    end
  end




  def conversation_params
    params.require(:conversation).permit(:recipient_id)
  end

  def signed_in_flash
    if !user_signed_in?
      flash[:alert] = "You must sign in to start a conversation"
      redirect_to users_path
    end
  end

  # def participant?
  #   @conversation = Conversation.find(params[:id])
  #   unless (current_user.id == @conversation.recipient_id) || (current_user.id == @conversation.sender_id)
  #     redirect_to users_path
  #     flash[:alert] = 'You are not authorized to enter this chat'
  #   end
  # end
end
