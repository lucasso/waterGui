require 'rails_helper'

RSpec.describe RfidLoginLog, type: :model do
	
	it "has a valid factory" do
		expect(FactoryBot.build(:rfid_login_log)).to be_valid
	end

	it "returns one failed log, leaving another which succeeded" do
		FactoryBot.create(:rfid_login_log, :number => 777, :success => true)
		failedLog = FactoryBot.create(:rfid_login_log, :number => 888, :success => false)
		expect(RfidLoginLog.get_last_failed()).to contain_exactly(failedLog)
	end

	it "returns most recent failed log, not older ones" do
		mostRecentFailedLog = FactoryBot.create(:rfid_login_log, :number => 777, :success => false, :created_at => 2.days.ago)
		FactoryBot.create(:rfid_login_log, :number => 888, :success => false, :created_at => 3.days.ago)
		expect(RfidLoginLog.get_last_failed(1)).to contain_exactly(mostRecentFailedLog)
	end

	it "returns no more than default (3) number of failed logins" do
		10.times { FactoryBot.create(:rfid_login_log, :success => false) }
		expect(RfidLoginLog.get_last_failed().length).to equal(3)
	end
end
