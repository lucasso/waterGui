class HomeController < ApplicationController
	
	skip_before_action :verify_authenticity_token, only: [:get_user_by_pinid, :get_user_by_rfid]
	before_action :authenticate_user!, except: [:get_user_by_pinid, :get_user_by_rfid, :index]

	layout "withmenu"

	def index
		redirect_to new_user_session_path unless user_signed_in?
	end
	
	def get_user_by_pinid
		if params[:client_id].blank? or params[:pin].blank?
			return_error :bad_request
		else
			matchingUsers = User.search_by_idpin(params[:client_id].to_f, params[:pin].to_f)

			if matchingUsers.empty?
				return_error :not_found
			elsif matchingUsers.length > 1
				return_error :conflict
			else
				myUser = matchingUsers.first
				logger.info "user #{myUser.email} with client_id:#{myUser.client_user_id} authorized, current credit #{myUser.credit}"

				if not params[:consumed_credit].blank?
					myUser.credit -= params[:consumed_credit].to_f
					myUser.save!
					logger.info "user #{myUser.email} with client_id:#{myUser.client_user_id} consumed #{params[:consumed_credit]} credit(s)"
				end
				
				render json: { credit: myUser.credit }, status: :ok
			end
		end
	end

	def get_user_by_rfid
		if params[:client_rfid].blank?
			return_error :bad_request
		else
			matchingRfid = Rfid.search_by_number(params[:client_rfid].to_f)

			loginLog = RfidLoginLog.create(:number => params[:client_rfid].to_f, :success => !matchingRfid.empty?)
			loginLog.save!

			if matchingRfid.empty?
				return_error :not_found
			elsif matchingRfid.length > 1
				return_error :conflict
			else
				myUser = matchingRfid.first.user
				logger.info "user #{myUser.email} authorized by client_rfid:#{matchingRfid.first.number}, current credit #{myUser.credit}"

				if not params[:consumed_credit].blank?
					myUser.credit -= params[:consumed_credit].to_f
					myUser.save!
					logger.info "user #{myUser.email} authorized by client_rfid:#{matchingRfid.first.number} consumed #{params[:consumed_credit]} credit(s)"
				end
				
				render json: { credit: myUser.credit }, status: :ok
			end
		end
	end


	private

	def return_error(code)
		head code, "content_type" => 'text/plain'
	end

end
