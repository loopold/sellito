require 'rails_helper'

describe CategoriesController do
	# metode index - # bo metoda instancji (nie metoda klasowa jak all first) 
	# dla klasowych robimy . zamiast #
	describe '#index' do
		it 'returns 200' do
			get :index
			expect(response.status).to be 200
		end
	end

	describe '#new' do
		it 'returns 200' do
			get :new
			expect(response.status).to be 200
		end
	end

	describe '#create' do
		context 'when params are valid' do
	 		# tutaj robimy unikalność zamiast  name: 'string'
	 		let(:params) { { category: { name: 'Time.now' } } }
	 		# let(:invalid_params) { { category: { name: '' } } }
	 		
	 		subject { post :create, params: params }
	 		
	 		it 'returns 302' do
	 			subject
	 			expect(response.status).to be 302
	 		end

	 		it 'create a category' do
	 			expect { subject }.to change { Category.count }.by(1)
	 		end
	 	end

	 	context 'when params are NOT valid' do
	 		let(:params) { { category: { name: '' } } }
	 		
	 		subject { post :create, params: params }

	 		it 'returns 302' do
	 			subject
	 			expect(response.status).to be 302
	 		end

	    # xit pokaże test jako pending - jeśli jest nie skończony
	    it 'does NOT create category when name is NOT valid' do
	    	expect { subject }.not_to change { Category.count }
	    end
	  end
	end

	describe '#show' do
		let(:category) { Category.create(name: 'test')}

		it 'returns 200' do
			get :show, params: { id: category.id }
			expect(response.status).to be 200
		end
	end
end