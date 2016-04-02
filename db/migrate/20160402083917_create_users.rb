class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :identifier, null: false, unique: true
      t.text :username, null: false, unique: true
      t.datetime :oldest, null: false, default: DateTime.now
      t.datetime :newest, null: false, default: DateTime.now

      t.timestamps null: false
    end
  end
end
