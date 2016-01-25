class ConversationsController < ApplicationController
  before_action :signed_in_flash, only: [:create]
  # before_action :participant?, only: [:show]
  def index
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
