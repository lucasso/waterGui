require 'rails_helper'

describe 'Water API', type: :request do
	it 'getuser_idpin returns bad request on no params' do
		post getuser_idpin_path, params: {}
		expect(response).to have_http_status(:bad_request)
	end

	it 'getuser_idpin returns bad request on pin param missing' do
		post getuser_idpin_path, params: { pin: 1234 }
		expect(response).to have_http_status(:bad_request)
	end

	it 'getuser_idpin returns bad request on client_id param missing' do
		post getuser_idpin_path, params: { client_id: 777 }
		expect(response).to have_http_status(:bad_request)
	end

	it 'getuser_idpin returns not_found when there is no user matchin client_id and pin' do
		post getuser_idpin_path, params: { pin: 1234, client_id: 777 }
		expect(response).to have_http_status(:not_found)
	end

	it 'getuser_idpin returns credits when client_id and pin match' do
		FactoryBot.create(:user, :client_user_id => 2002, :client_pin => 1111, :credit => 18)
		post getuser_idpin_path, params: { pin: 1111, client_id: 2002 }
		expect(response).to have_http_status(:success)
		json = JSON.parse(response.body)
		expect(json.length).to eq 1
		expect(json['credit']).to eq 18
		
	end

	it 'getuser_idpin consumes credits when consumed_credit is non-zero' do
		FactoryBot.create(:user, :client_user_id => 2002, :client_pin => 1111, :credit => 18)
		post getuser_idpin_path, params: { pin: 1111, client_id: 2002, consumed_credit: 3 }
		expect(response).to have_http_status(:success)
		json = JSON.parse(response.body)
		expect(json.length).to eq 1
		expect(json['credit']).to eq 15
	end


	it 'getuser_rfid returns bad request on no params' do
		post getuser_rfid_path, params: {}
		expect(response).to have_http_status(:bad_request)
	end

	it 'getuser_rfid returns not_found when there is no user matching client_rfid' do
		post getuser_rfid_path, params: { client_rfid: 777 }
		expect(response).to have_http_status(:not_found)
	end

	it 'getuser_rfid returns credits when client_rfid matches' do
		user = FactoryBot.create(:user, :credit => 188)
		rfid = FactoryBot.create(:rfid, :number => 9898, :user => user)
		post getuser_rfid_path, params: { client_rfid: 9898 }
		expect(response).to have_http_status(:success)
		json = JSON.parse(response.body)
		expect(json.length).to eq 1
		expect(json['credit']).to eq 188
	end

	it 'getuser_rfid consumes credits when consumed_credit is non-zero' do
		user = FactoryBot.create(:user, :credit => 188)
		rfid = FactoryBot.create(:rfid, :number => 9898, :user => user)
		post getuser_rfid_path, params: { client_rfid: 9898, consumed_credit: 180 }
		expect(response).to have_http_status(:success)
		json = JSON.parse(response.body)
		expect(json.length).to eq 1
		expect(json['credit']).to eq 8
	end


end
		
