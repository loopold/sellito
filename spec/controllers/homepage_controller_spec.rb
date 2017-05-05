require 'rails_helper'

describe HomepageController do
	describe '#index' do
		it 'returns 200' do
			get :index
			expect(response.status).to be 202			
		end
	end
end