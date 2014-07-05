require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  render_views
  fixtures :all
  describe 'GET' do
    context 'with product exist' do
      before {
        expect(Product).to receive(:find).and_return(products(:book))
        get :show, id: 1, format: :json
        @product = JSON.parse(response.body)
      }
      it 'should success' do
        expect(response).to have_http_status 200
      end

      it 'should return name' do
        expect(@product['name']).to eq('ruby')
      end
      it 'should return description' do
        expect(@product['description']).to eq('ruby book')
      end

      it 'should return uri' do
        expect(@product['uri']).to end_with('/products/1')
      end
    end

    context 'with product non exist' do
      before {
        expect(Product).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, id: 999
      }
      it 'should success' do
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'POST' do
    context 'post to create' do
      before {
        expect(Product).to receive(:new).with({name: 'name', description: 'description'}).and_call_original
        expect_any_instance_of(Product).to receive(:save).and_call_original
        post :create , product: {name: 'name', description: 'description'}
      }

      it 'should return 201' do
        expect(response).to have_http_status 201
      end

      it 'should return uri' do
        expect(response['Location']).to match(%r{products/\d*})
      end
    end
  end
end
