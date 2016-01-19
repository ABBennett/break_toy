class MessagesController < ApplicationController
  #
  # def index
  #   binding.pry
  #   @conversation = Conversation.find(params[:conversation_id])
  #   @messages = @conversation.messages
  # end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save!
      respond_to do |format|
        format.js # render messages/create.js.erb
        format.html { redirect_to conversation_path(@conversation) }
      end
    else
      redirect_to users_path
      flash[:alert] = 'You are unable to chat with this user'
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
