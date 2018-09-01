class DrinkersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :is_admin?

	respond_to :html, :xml, :json

	def index
		respond_with @users = User.all
	end
	
	def show
		respond_with @user
	end
	
	def new
		respond_with @user = User.new
	end
	
	def edit
		respond_with @user
	end
	
	def create
		# In order to set the flash, we need to know if the create was successful.
		# Since `create` always returns an object we won't know if it's successful,
		# without re-validating or checking the errors.
		#
		# The cleaner way is to just initialize a new object, then check the call
		# to save; which will be truthy on a valid model and successful save.
		@user = User.new(user_params)
		
		if @user.save
			flash[:notice] = "User was successfully created."
		end
		
		respond_with @user
	end
	
	def update
		# Update returns truthy if the model was valid and the save successful.
		# So it's fine to just make the call.
		if @user.update(user_params)
			flash[:notice] = "User was successfully updated."
		end
		
		# respond_with is very smart / magical. It knows that only on a
		# successful update should the location option be used as a
		# redirect.
		respond_with @user, location: root_url
	end
	
	def destroy
		@user.destroy
		
		flash[:notice] = "User was successfully destroyed."
		
		redirect_to drinkers_url
	end
	
	private
	
	def set_user
		@user = User.find(params[:id])
	end
	
	def user_params
		params[:user].permit(:title, :isbn, :price)
	end


	def is_admin?
		# check if user is a admin
		# if not admin then redirect to where ever you want 
		redirect_to root_path unless current_user.admin? 
    end

end
