users = []
10.times do
  users << User.new(
    email: Faker::Internet.email,
    username: Faker::Internet.user_name,
    encrypted_password: "password",
  )
end

users.each do |user|
  user.save!(validate: false)
end
