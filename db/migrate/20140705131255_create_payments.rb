class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :order
      t.float :amount
      t.string :pay_type
      t.timestamps
    end
  end
end
