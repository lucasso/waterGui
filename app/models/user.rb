class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	
	scope :search_by_idpin, ->(clientUserId, clientPin) {
		where(:client_user_id => clientUserId, :client_pin => clientPin)
	}

	has_many :rfids, inverse_of: :user
	accepts_nested_attributes_for :rfids, allow_destroy: true

	validates_numericality_of :client_pin, :client_user_id
	validates :client_pin, presence: true
	validates :client_user_id, uniqueness: true, presence: true

end
