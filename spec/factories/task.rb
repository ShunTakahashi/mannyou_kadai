FactoryBot.define do
  factory :task do
    title { 'Task' }
    content { rand(2) }
  end
end
