# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: 'admin',
  email: 'test@test.com',
  password: '12345678',
  admin: true,
)

Label.create(label_name: "勉強")
Label.create(label_name: "趣味")
Label.create(label_name: "遊び")
Label.create(label_name: "仕事")