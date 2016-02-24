FactoryGirl.define do
  factory :snippet do
    sequence(:title){|n| "#{Faker::Company.bs}-#{n}"}
    sequence(:body){|n| "#{Faker::Lorem.paragraph}-#{n}"}
    language
    user
  end
end
