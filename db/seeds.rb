# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["ruby", "html", "css", "javascript"].each do |kind|
  Language.create(kind: kind)
end

# 100.times do |x|
#   Snippet.create title: Faker::Company.bs,
#                   body: Faker::Lorem.paragraph,
#                   user: User.find(rand(3)+1),
#                   language: Language.find(rand(4)+1)
# end
