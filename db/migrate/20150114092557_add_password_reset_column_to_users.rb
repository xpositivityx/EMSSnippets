class AddPasswordResetColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset, :string
    add_column :users, :password_reset_sent, :timestamp
  end
end
