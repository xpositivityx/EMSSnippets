class AddDistractor3ToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :distractor3, :string
  end
end
