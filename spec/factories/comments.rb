FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.word }
    user 
    movie 
  end
end
