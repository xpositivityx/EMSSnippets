class AddCorrectQuestionsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :questions_correct, :string
  end
end
