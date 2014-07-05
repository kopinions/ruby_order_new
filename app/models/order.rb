class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user, inverse_of: :orders
  has_one :payment, inverse_of: :order
end
