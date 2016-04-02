class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :username, null: false
      t.string :name, null: false

      t.index [:username, :name], unique: true

      t.timestamps null: false
    end
  end
end
