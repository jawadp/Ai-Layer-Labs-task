FactoryBot.define do
  factory :comment do
    text { 'This is a test comment' }
    association :user
    association :post
  end
end
