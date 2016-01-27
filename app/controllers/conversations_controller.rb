class ConversationsController < ApplicationController
  before_action :signed_in_flash, only: [:create]
  # before_action :participant?, only: [:show]

  def index
    if params[:order] == "totalpoints"
      @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.sender.average_score + a.recipient.average_score <=> b.sender.average_score + b.recipient.average_score }).page(params[:page]).per(10)
    elsif params[:order] == "message"
        @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.messages.count <=> b.messages.count }).page(params[:page]).per(10)
    elsif params[:order] == "points"
        @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.sender.total + a.recipient.total <=> b.sender.total + b.recipient.total }).page(params[:page]).per(10)
    elsif params[:order] == "sender"
      @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.sender.average_score || a.recipient.average_score <=> b.sender.average_score || b.recipient.average_score }).page(params[:page]).per(10)
    elsif params[:order] == "recipient"
        @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| a.recipient.average_score <=> b.recipient.average_score }).page(params[:page]).per(10)
    elsif params[:order] == "lopsided"
        @conversations = Kaminari.paginate_array(Conversation.all.sort{ |b,a| abs(a.recipient.average_score - a.sender.average_score) <=> abs(b.recipient.average_score - b.sender.average_score) }).page(params[:page]).per(10)
    else
      @conversations = Conversation.all.order("created_at DESC").page(params[:page]).per(20)
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
