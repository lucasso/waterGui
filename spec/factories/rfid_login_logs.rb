FactoryBot.define do
	factory :rfid_login_log do
		sequence(:number) { |n| 10001000 + n }
		success false
	end
end
