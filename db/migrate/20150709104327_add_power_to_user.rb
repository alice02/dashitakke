class AddPowerToUser < ActiveRecord::Migration
  def change
    add_column :users, :fighting_power, :integer, default: 0
  end
end
