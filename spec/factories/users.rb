FactoryBot.define do
  factory :user do
    name {'test'}
    sequence(:email) { |n| "tester#{n}@example.com" }
    password {'12345678'}
  end
end


