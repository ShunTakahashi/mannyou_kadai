FactoryBot.define do
  factory :user, class: User do
    id {1}
    name {'test1'}
    sequence(:email) {|n| "tester#{n}@example.com"}
    password {'12345678'}
    password_confirmation {'12345678'}
  end

  factory :test_user, class: User do
    id {2}
    name {'test2'}
    email {'test@sample'}
    password {'12345678'}
    password_confirmation {'12345678'}
  end
end


