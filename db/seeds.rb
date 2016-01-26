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

200.times do
  users_array = User.all
  conversations << Conversation.new(
    sender: users_array.shuffle.pop,
    recipient: users_array.shuffle.pop,
    title: Faker::Hacker.noun,
  )
end

conversations.each do |conversation|
  conversation.save!
end

1000.times do
  conversation = Conversation.all.sample
  messages << Message.new(
    body: Faker::Hipster.sentence,
    conversation: conversation,
    user: conversation.sender,
  )
  messages << Message.new(
    body: Faker::Hipster.sentence,
    conversation: conversation,
    user: conversation.recipient,
  )
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
