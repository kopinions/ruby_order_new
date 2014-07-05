object @payment
attribute :amount, :pay_type
node :uri do |payment|
    payment_user_order_path @user, @order
end