require 'rails_helper'

RSpec.describe User, type: :model do
	
	it "has a valid factory" do
		expect(FactoryBot.build(:user)).to be_valid
	end

	it "is invalid with duplicate email address" do
		user1 = FactoryBot.create :user
		user2 = FactoryBot.build(:user, :email => user1.email)

		expect(user2).to be_invalid
	end

	it "returns user matching pin and client_id" do
		matchingUser = FactoryBot.create(:user, :client_user_id => 777, :client_pin => 8888)
		FactoryBot.create(:user, :client_pin => 8888)
    
		expect(User.search_by_idpin(777, 8888)).to contain_exactly(matchingUser)
	end

	it "don't return user matching client_id but not pin" do
		FactoryBot.create(:user, :client_user_id => 777, :client_pin => 8881)
    
		expect(User.search_by_idpin(777, 8888)).to be_empty

	end

		
end
