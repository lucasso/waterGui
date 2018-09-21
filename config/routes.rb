Rails.application.routes.draw do
	devise_for :users
	get 'home/index'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root to: "home#index"
	post 'getuser_idpin' => "home#get_user_by_pinid"

	resources :drinkers do
		resources :rfids
	end
end
