class RemoveAvailableInventoryDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :movies, :available_inventory, nil
  end
end
