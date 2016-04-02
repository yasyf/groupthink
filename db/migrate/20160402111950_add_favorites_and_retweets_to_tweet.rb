class AddFavoritesAndRetweetsToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :favorites, :integer, null: false, default: 0
    add_column :tweets, :retweets, :integer, null: false, default: 0
  end
end
