require 'rails_helper'

RSpec.describe ProductController, :type => :controller do
  describe 'GET' do
    context 'with product exist' do
      before {
        expect(Product).to receive(:find).and_return(Product.new)
        get :show, id: 1
      }
      it 'should success' do
        expect(response).to have_http_status 200
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
