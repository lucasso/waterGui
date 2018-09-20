class DrinkersController < ApplicationController

	before_action :authenticate_user!

	before_action :set_drinker, only: [:show, :edit, :update, :destroy]
	before_action :is_admin?

	respond_to :html, :xml, :json

	layout "withmenu"

	def index
		respond_with @drinkers = User.all
	end
	
	def show
		respond_with @drinker
	end
	
	def new
		respond_with @drinker = User.new
	end
	
	def edit
		respond_with @drinker
	end
	
	def create
		# In order to set the flash, we need to know if the create was successful.
		# Since `create` always returns an object we won't know if it's successful,
		# without re-validating or checking the errors.
		#
		# The cleaner way is to just initialize a new object, then check the call
		# to save; which will be truthy on a valid model and successful save.
		@drinker = User.new(user_params)
		@drinker.password = user_params[:client_pin]

		logger.info "tworze usera"
		
		if @drinker.save
			flash[:notice] = "User was successfully created."
			redirect_to action: "index"
		else
			flash[:alert] = "Failed to save user #{@drinker.errors.full_messages}"
			logger.info "nieudane #{@drinker.errors.full_messages}"
			respond_with @drinker
		end
	end
	
	def update
		# Update returns truthy if the model was valid and the save successful.
		# So it's fine to just make the call.
		if @drinker.update(user_params)
			flash[:notice] = "User was successfully updated."
		end
		
		# respond_with is very smart / magical. It knows that only on a
		# successful update should the location option be used as a
		# redirect.
		respond_with @drinker, location: root_url
	end
	
	def destroy
		@drinker.destroy
		
		flash[:notice] = "User was successfully destroyed."
		
		redirect_to drinkers_url
	end
	
	private
	
	def set_drinker
		@drinker = User.find(params[:id])
	end
	
	def user_params
		params[:user].permit(:client_user_id, :client_pin, :admin, :email, :credit)
	end


	def is_admin?
		# check if user is a admin
		# if not admin then redirect to where ever you want 
		redirect_to root_path unless current_user.admin? 
    end

end
