class RatingsController < ApplicationController

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    @conversation = Conversation.find(params[:conversation_id])
    @rating.conversation = @conversation

    if @rating.save
      @conversation.update_attribute(:rated?, true)
      respond_to do |format|
        format.html { redirect_to @conversation }
        format.js # render ratings/create.js.erb
      end
    else
      redirect_to conversation_path(@conversation)
      flash[:alert] = 'You can only rate once!'
    end
  end

  def rating_params
    params.require(:rating).permit(:score, :ratee_id, :rater_id, :conversation_id)
  end
end
