class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :author
      t.string :subject
      t.string :catagory
      t.string :topic
      t.string :subtopic1
      t.string :subtopic2
      t.string :stem
      t.string :image
      t.string :answer
      t.string :distractor1
      t.string :distractor2
      t.string :distractor2
      t.integer :difficulty
      t.string :explaination
      t.integer :bias

      t.timestamps
    end
  end
end
