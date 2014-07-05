require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  describe 'GET' do
    context 'with exist order' do
      before {
        get :show, user_id: 1, id: 2
      }

      it 'should return 200' do
        expect(response).to have_http_status 200
      end
    end
  end
end
