object @order
attributes :address, :phone, :name

node :uri do |order|
    user_order_path @user, order
end