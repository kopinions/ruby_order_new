class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user, inverse_of: :orders
end
