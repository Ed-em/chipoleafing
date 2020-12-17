# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# name = Faker::TvShows::TheITCrowd.character #=> "Roy Trenneman"
# email = Faker::TvShows::TheITCrowd.email #=> "roy.trenneman@reynholm.test"
# password = "password"
# User.create!(name: name,
  #           email: email,
  #           password: password,
  #           password_confirmation: password,
  #           )
  50.times do |n|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 )
  end
# user = User.create(name: "Chipo", email: "chipo2@gmail.com", password: "Hyunjoong1*", password_confirmation: "Hyunjoong1*", admin: true)
