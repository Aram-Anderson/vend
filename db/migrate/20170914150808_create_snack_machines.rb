class CreateSnackMachines < ActiveRecord::Migration[5.1]
  def change
    create_table :snack_machines do |t|
      t.belongs_to :snack
      t.belongs_to :machine

      t.timestamps
    end
  end
end
