class CreateJoinTableTweetLink < ActiveRecord::Migration
  def change
    create_join_table :tweets, :links do |t|
      t.index [:tweet_id, :link_id]
      t.index [:link_id, :tweet_id]
    end
  end
end
