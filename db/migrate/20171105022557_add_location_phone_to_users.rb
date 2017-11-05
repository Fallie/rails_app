class AddLocationPhoneToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :location, :string
	add_column :users, :postcode, :string
	add_column :users, :phone_number, :string
  end
end
