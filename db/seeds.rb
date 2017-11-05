# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Fallie',
          email: 'falliearc@gmail.com',
          password: '123',
          role: 'Admin',
          phone_number: '0445555555',
          location: '1 Park St, Docklands, VIC',
          postcode: '3009')

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123"
  role = (n%2 == 0) ? 'patient' : 'doctor'
  User.create!(name: name,
          email: email,
          password: '123',
          role: role,
          phone_number: '0445555555',
          location: '1 Park St, Docklands, VIC',
          postcode: '3009')
end