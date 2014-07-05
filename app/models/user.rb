class User < ActiveRecord::Base
  has_many :orders, inverse_of: :user
end
