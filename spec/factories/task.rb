FactoryBot.define do
  factory :task do
    title {'Task'}
    content {rand(2)}
    user { User.first || association(:user) }
  end
end
