class AddColumnToUser < ActiveRecord::Migration
  def change
  	add_column :users, :correct_count, :integer
  end
end
