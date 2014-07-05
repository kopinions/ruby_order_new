require 'rails_helper'

RSpec.describe ProductController, :type => :controller do
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
end
