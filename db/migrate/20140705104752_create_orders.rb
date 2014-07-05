class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.string :name
      t.string :phone
      t.belongs_to :user
      t.timestamps
    end
  end
end
