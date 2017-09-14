class ChangePriceToDecimal < ActiveRecord::Migration[5.1]
  def change
    change_column :snacks, :price, :decimal
  end
end
