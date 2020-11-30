FactoryBot.define do
  factory :license do
    key { Faker::Blockchain::Bitcoin.address }
    game
  end
end
