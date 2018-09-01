class DrinkersController < ApplicationController

before_action :set_book, only: [:show, :edit, :update, :destroy]

	respond_to :html, :xml, :json

	def index
		respond_with @books = Book.all
	end
	
	def show
		respond_with @book
	end
	
	def new
		respond_with @book = Book.new
	end
	
	def edit
		respond_with @book
	end
	
	def create
		# In order to set the flash, we need to know if the create was successful.
		# Since `create` always returns an object we won't know if it's successful,
		# without re-validating or checking the errors.
		#
		# The cleaner way is to just initialize a new object, then check the call
		# to save; which will be truthy on a valid model and successful save.
		@book = Book.new(book_params)
		
		if @book.save
			flash[:notice] = "Book was successfully created."
		end
		
		respond_with @book
	end
	
	def update
		# Update returns truthy if the model was valid and the save successful.
		# So it's fine to just make the call.
		if @book.update(book_params)
			flash[:notice] = "Book was successfully updated."
		end
		
		# respond_with is very smart / magical. It knows that only on a
		# successful update should the location option be used as a
		# redirect.
		respond_with @book, location: root_url
	end
	
	def destroy
		@book.destroy
		
		flash[:notice] = "Book was successfully destroyed."
		
		respond_with @book
	end
	
	private
	
	def set_book
		@book = Book.find(params[:id])
	end
	
	def book_params
		params[:book].permit(:title, :isbn, :price)
	end
end
