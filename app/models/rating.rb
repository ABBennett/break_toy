class Rating < ActiveRecord::Base
  belongs_to :rater, :foreign_key => :rater_id, class_name: 'User'
  belongs_to :ratee, :foreign_key => :ratee_id, class_name: 'User'
  belongs_to :conversation

  scope :involving, -> (user) do
    where("ratings.rater_id =? OR ratings.ratee_id =?",user.id,user.id)
  end

end
