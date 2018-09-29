class CreateRfidLoginLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :rfid_login_logs do |t|
      t.integer :number, :limit => 8
      t.boolean :success

      t.timestamps
    end
  end
end
