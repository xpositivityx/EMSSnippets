class AddCorrectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :correct, :integer
    add_column :users, :incorrect, :integer
  end
end
