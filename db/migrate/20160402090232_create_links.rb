class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :url, null: false, unique: true
      t.text :title, null: false
      t.text :summary, null: false

      t.timestamps null: false
    end
  end
end
