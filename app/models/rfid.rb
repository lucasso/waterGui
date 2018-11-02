class Rfid < ApplicationRecord
	belongs_to :user
	validates :number, uniqueness: true, presence: true

	scope :search_by_number, ->(clientRfid) {
		where(:number => clientRfid)
	}

end
