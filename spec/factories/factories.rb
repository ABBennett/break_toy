FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User#{n}" }
    sequence(:email) { |n| "person#{n}@gmail.com" }
    password '12345678'
  end

  factory :conversation do
    sender { FactoryGirl.create :user }
    recipient { FactoryGirl.create :user }
  end

  factory :message do
    conversation
  end

  # factory :rating do
  #   conversation
  #   rater { FactoryGirl.create :user }
  #   ratee { FactoryGirl.create :user }
  # end

end
