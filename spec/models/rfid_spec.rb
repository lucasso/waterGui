require 'rails_helper'

RSpec.describe Rfid, type: :model do

	it "has a valid factory" do
		expect(FactoryBot.build(:rfid)).to be_valid
	end

	it "is invalid with duplicate number" do
		rfid1 = FactoryBot.create :rfid
		rfid2 = FactoryBot.build(:rfid, :number => rfid1.number)

		expect(rfid2).to be_invalid
	end

	it "is invalid without number" do
		expect(FactoryBot.build(:rfid, :number => nil)).to be_invalid
	end

	it "is invalid without user" do
		expect(FactoryBot.build(:rfid, :user => nil)).to be_invalid
	end

	it "returns rfid matching number" do
		rfid = FactoryBot.create(:rfid, :number => 777)    
		expect(Rfid.search_by_number(777)).to contain_exactly(rfid)
	end

	it "doesn't return rfid not matching number" do
		rfid = FactoryBot.create(:rfid, :number => 777)    
		expect(Rfid.search_by_number(888)).to be_empty
	end



end
