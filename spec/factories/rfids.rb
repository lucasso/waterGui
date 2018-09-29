FactoryBot.define do
  factory :rfid do
    user
    sequence(:number) { |n| 3000+n }
  end
end
