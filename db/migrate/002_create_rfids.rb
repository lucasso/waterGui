class CreateRfids < ActiveRecord::Migration[5.2]
  def change
    create_table :rfids do |t|
      t.references :user, foreign_key: true
      t.integer :number, :limit => 8

      t.timestamps
    end
  end
end
