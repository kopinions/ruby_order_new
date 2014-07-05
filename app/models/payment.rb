class Payment < ActiveRecord::Base
  belongs_to :order, inverse_of: :payment
end
