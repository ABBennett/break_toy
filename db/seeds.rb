users = []
conversations = []
messages = []
ratings = []

20.times do
  users << User.new(
    email: Faker::Internet.email,
    username: Faker::Internet.user_name,
    encrypted_password: "password",
  )
end

users.each do |user|
  user.save!(validate: false)
end

40.times do
  users_array = User.all
  conversation = Conversation.new(
    sender: users_array.shuffle.pop,
    recipient: users_array.shuffle.pop,
    title: Faker::Hacker.noun,
  )
  conversation.created_at = (rand*20).days.ago
  conversations << conversation
end

conversations.each do |conversation|
  conversation.save!
end

200.times do
  conversation = Conversation.all.sample
  message = Message.new(
    body: Faker::Hipster.sentence,
    conversation: conversation,
    user: conversation.sender,
  )
  message.created_at = Date.today + rand(200).minutes
  time = message.created_at
  messages << message

  message2 = Message.new(
    body: Faker::Hipster.sentence,
    conversation: conversation,
    user: conversation.recipient,
  )
  message2.created_at = time + rand(10).minutes
  messages << message2
end
messages.each do |message|
  message.save!
end

conversations.each do |conversation|
  ratings << Rating.new(
    rater: conversation.sender,
    ratee: conversation.recipient,
    conversation: conversation,
    score: rand(1..10)
  )
end
ratings.each do |rating|
  rating.save!
end
