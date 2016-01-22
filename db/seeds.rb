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

100.times do
  conversations << Conversation.new(
    sender: User.all.sample,
    recipient: User.all.sample,
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

# 10.times do
#   ratings << Rating.new(
#     rater: User.all.sample,
#     ratee: User.all.sample,
#     conversation
#   )
#
