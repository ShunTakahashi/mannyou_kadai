FactoryBot.define do
  factory :task do
    title { 'Task' }
    content { rand(2) }
    association :user, factory: :user
  end
end
