FactoryBot.define do
	factory :user do
		sequence(:email) { |n| "tester#{n}@example.com" }
		password "somePass"
		sequence(:client_user_id) { |n| 1000 + n }
		client_pin 1234
	end
end
