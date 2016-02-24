FactoryGirl.define do
  factory :language do
    sequence(:kind) {|n| "#{n}-MyString"}
  end
end
