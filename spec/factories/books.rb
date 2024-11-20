FactoryBot.define do
  factory :book do
    title { Faker::Lorem.characters(number: 5) }
    opinion { Faker::Lorem.characters(number: 20) }
    user
  end
end
