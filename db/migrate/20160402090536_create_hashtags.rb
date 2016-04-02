class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :tag, unique: true

      t.timestamps null: false
    end
  end
end
