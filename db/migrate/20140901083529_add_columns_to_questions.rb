class AddColumnsToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :tag1, :string
  	add_column :questions, :tag2, :string
  	add_column :questions, :tag3, :string
  end
end
