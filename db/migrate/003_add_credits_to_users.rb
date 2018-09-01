class AddCreditsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :credit, :integer, :null => false, :default => 0
  end
end
