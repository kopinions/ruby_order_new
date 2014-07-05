require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  fixtures :all
  describe 'GET' do

    context 'with exist order' do
      before {
        expect(User).to receive(:find).with(1).and_return(users(:sofia))
        expect(Order).to receive(:find).with(2).and_return(orders(:buy_ruby))
        get :show, user_id: 1, id: 2
      }

      it 'should return 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'with none exist order' do
      it 'should return 404' do
        expect(User).to receive(:find).with(1).and_return(users(:sofia))
        expect(Order).to receive(:find).with(-1).and_raise(ActiveRecord::RecordNotFound)
        get :show, user_id: 1, id: -1
        expect(response).to have_http_status 404
      end
    end

    context 'with none exist user' do
      it 'should return 404' do
        expect(User).to receive(:find).with(1).and_raise(ActiveRecord::RecordNotFound)
        get :show, user_id: 1, id: 2
        expect(response).to have_http_status 404
      end
    end
  end
end
