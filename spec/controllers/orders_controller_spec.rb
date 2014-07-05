require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  render_views
  fixtures :all
  describe 'GET' do
    context 'with exist user' do
      before {
        expect(User).to receive(:find).with(1).and_return(users(:sofia))
      }
      context 'with exist order' do
        before {
          expect(Order).to receive(:find).with(2).and_return(orders(:buy_ruby))
          get :show, user_id: 1, id: 2, format: :json
          @order = JSON.parse(response.body)
        }

        it 'should return 200' do
          expect(response).to have_http_status 200
        end

        it 'should return order address' do
          expect(@order['address']).to eq('beijing')
        end

        it 'should return phone' do
          expect(@order['phone']).to eq(orders(:buy_ruby).phone)
        end

        it 'should return name' do
          expect(@order['name']).to eq(orders(:buy_ruby).name)
        end

        it 'shoule return uri' do
          expect(@order['uri']).to end_with('/users/1/orders/' + orders(:buy_ruby).id.to_s)
        end
      end

      context 'with none exist order' do
        it 'should return 404' do
          expect(Order).to receive(:find).with(-1).and_raise(ActiveRecord::RecordNotFound)
          get :show, user_id: 1, id: -1, format: :json
          expect(response).to have_http_status 404
        end
      end
    end

    context 'with none exist user' do
      it 'should return 404' do
        expect(User).to receive(:find).with(1).and_raise(ActiveRecord::RecordNotFound)
        get :show, user_id: 1, id: 2, format: :json
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'POST' do
    context 'with exist user' do
      before {
        expect(User).to receive(:find).with(1).and_return(users(:sofia))
      }

      context 'post to create' do
        before {
          expect(Order).to receive(:new).with({address: 'beijing', phone: '13211112222', name: 'kayla'}).and_call_original
          # why 2, it is because the first time is use to save order, the second
          # time is use to save the user_id in the order
          expect_any_instance_of(Order).to receive(:save).exactly(2).and_call_original
          post :create, user_id: 1, order: {address: 'beijing', phone: '13211112222', name: 'kayla', order_items: [{product_id: 1, quantity: 2}]}
        }

        it 'should get 201' do
          expect(response).to have_http_status 201
        end

        it 'should return location' do
          expect(response['Location']).to match(%r{users/1/orders/\d*})
        end

        it 'should create order a order for sofia' do
          expect(users(:sofia).orders.length).to eq(2)
        end

        it 'should order have one order item' do
          expect(users(:sofia).orders[1].order_items.length).to eq(1)
        end

        it 'should order item info equal to send' do
          expect(users(:sofia).orders[1].order_items[0].product_id).to eq(1)
          expect(users(:sofia).orders[1].order_items[0].quantity).to eq(2)
        end
      end
    end
  end

  describe 'Payment' do
    context 'with exist user' do
      before {
        expect(User).to receive(:find).with(1).and_return(users(:sofia))
      }
      context 'with exist order' do
        context 'post payment' do
          before {
            expect(Payment).to receive(:new).with({amount:100, pay_type: 'CASH'}).and_call_original
            post :payment, id: 2, user_id: 1, format: :json, payment: {amount: 100, pay_type: 'CASH'}
          }

          it 'should create payment for order' do
            expect(response).to have_http_status 201
          end

          it 'should return uri' do
            expect(response['Location']).to end_with('/users/1/orders/2/payment')
          end
        end

        context 'get payment' do
          before {
            get :payment, user_id: 1, id: 2, format: :json
          }

          it 'should get 200' do
            expect(response).to have_http_status 200
          end
        end

      end
    end
  end
end
