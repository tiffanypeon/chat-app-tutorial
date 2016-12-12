password = 'pass123'
1.upto(5) do |i|
  User.create(
    email: "user-#{i}@example.com",
    password: password,
    password_confirmation: password
  )
end

Group.create!(topic: 'Ruby')
Group.create!(topic: 'Javascript')
Group.create!(topic: 'CSS')
Group.create!(topic: 'Bootcamps')
