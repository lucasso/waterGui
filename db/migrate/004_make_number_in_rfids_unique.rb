class MakeNumberInRfidsUnique < ActiveRecord::Migration[5.2]
	def change
		change_column_null :rfids, :number, false
		add_index :rfids, :number, unique: true
	end
end
