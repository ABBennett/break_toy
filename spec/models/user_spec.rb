require 'rails_helper'

describe User do
  it { should have_valid(:username).when('John', 'Sally') }
  it { should_not have_valid(:username).when('', nil) }
  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when('userexample.com', nil, 'users@com') }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  it 'should calculate the appropriate numbers' do
    user = User.create!(username: "u", email: "u@u.com", password: "12345678")
    user2 = User.create!(username: "t", email: "t@u.com", password: "12345678")
    user3 = User.create!(username: "d", email: "d@u.com", password: "12345678")

    convo = Conversation.create!(sender: user, recipient: user2)
    rating = Rating.create!(rater: user, ratee: user2, conversation: convo, score: 10)
    rating2 = Rating.create!(rater: user2, ratee: user, conversation: convo, score: 1)

    convo2 = Conversation.create!(sender: user, recipient: user2)
    rating = Rating.create!(rater: user, ratee: user2, conversation: convo2, score: 10)
    rating2 = Rating.create!(rater: user2, ratee: user, conversation: convo2, score: 2)

    convo3 = Conversation.create!(sender: user, recipient: user3)
    rating = Rating.create!(rater: user, ratee: user3, conversation: convo3, score: 10)
    rating3 = Rating.create!(rater: user3, ratee: user, conversation: convo3, score: 3)

    expect(user.average_score).to be(2.0)
    expect(user2.average_score).to be(10.0)

    expect(user.average_rate).to be(10.0)
    expect(user2.average_rate).to be(1.5)

    expect(user.total).to be(6)
    expect(user2.total).to be(20)

    expect(user.total_rates).to be(30)
    expect(user2.total_rates).to be(3)

    expect(user.tens).to be(0)
    expect(user2.tens).to be(2)

  end
end
