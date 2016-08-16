class ChangeDataTypeForExplaination < ActiveRecord::Migration
  def change
  	change_column :questions, :explaination, :text
  end
end
