class RfidsController < ApplicationController

	before_action :authenticate_user!
	before_action :is_admin?

	before_action :set_drinker, only: [:new, :create]

	respond_to :html

	layout "withmenu"

	def new
		respond_with @rfid = @drinker.rfids.build
	end

	def create
		
		@rfid = Rfid.new(rfid_params)
		
		if @rfid.save
			flash[:notice] = "Rfid for user #{@drinker.email} was successfully created."
			redirect_to drinker_path(@drinker.id)
		else
			flash[:alert] = "Failed to save rfid, #{@rfid.errors.full_messages}"
			logger.info "nieudane #{@drinker.errors.full_messages}"
			respond_with @rfid # = @drinker.rfids.build
		end
	end

	private

	def rfid_params
		params[:rfid].permit(:number)
	end

	def is_admin?
		redirect_to root_path unless current_user.admin? 
    end

	def set_drinker
		begin
			@drinker = User.find(params[:drinker_id])
		rescue ActiveRecord::RecordNotFound
			flash[:alert] = "Failed to save RFID, no user with ID #{params[:drinker_id]}"
			redirect_to drinkers_path
		end

	end

end
