class RatingsController < ApplicationController

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.conversation = Conversation.find(params[:conversation_id])

    if @rating.save
      redirect_to users_path
    end
  end

  def rating_params
    params.require(:rating).permit(:score, :ratee_id, :rater_id, :conversation_id)
  end
end
