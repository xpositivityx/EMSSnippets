class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.integer :itemsAnswered
      t.integer :itemsCorrect
      t.integer :score
      t.integer :Rank

      t.timestamps
    end
  end
end
