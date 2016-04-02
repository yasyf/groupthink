class AddPostedAtToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :posted_at, :datetime, null: false, default: DateTime.now
  end
end
