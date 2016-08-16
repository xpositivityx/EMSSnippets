class AddCorrectToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :correct, :integer
    add_column :questions, :incorrect, :integer
  end
end
