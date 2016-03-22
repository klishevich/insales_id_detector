class AddHasCounterToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :has_counter, :boolean, default: false
  end
end
