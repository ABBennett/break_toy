class MessagesController < ApplicationController

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    @path = conversation_path(@conversation)

    if @message.save!
      respond_to do |format|
        format.js # render messages/create.js.erb
        format.html { redirect_to conversation_path(@conversation) }
        PrivatePub.publish_to(@path, message: @message)
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
