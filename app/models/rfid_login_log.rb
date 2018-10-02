class RfidLoginLog < ApplicationRecord

	scope :get_last_failed, ->(resultsNumber = 3) {
		where(:success => false).where.not(number: Rfid.pluck(:number) ).order(:created_at).reverse_order().limit(resultsNumber)
	}

end
