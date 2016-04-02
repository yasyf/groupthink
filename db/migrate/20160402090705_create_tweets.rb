class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :identifier, unique: true
      t.belongs_to :user, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :tweets, :users
  end
end
