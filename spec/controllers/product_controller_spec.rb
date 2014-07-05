require 'rails_helper'

RSpec.describe ProductController, :type => :controller do
  describe 'GET' do
    context 'with product exist' do
      before {
        get :show, id: 1
      }
      it 'should success' do
        expect(response).to have_http_status 200
      end
    end
  end
end
