class ConversationsController < ApplicationController
  def index
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
    @messages = @conversation.messages
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
end
