class List < ActiveRecord::Base
  include Concerns::Twitterable
  include Concerns::Cacheable

  def users
    @users ||= cached do
      twitter.list_members(username, name).map do |user|
        User.import! user
      end
    end
  end

  def sync!
    users.each(&:sync)
  end

  def tweets(oldest = 2.weeks.ago, newest = DateTime.now)
    @tweets ||= Tweet.where(user: users).where('posted_at > ?', oldest).where('posted_at < ?', newest)
  end

  def links
    @link ||= Link.joins(:links_tweets)
                   .joins(:tweets)
                   .where('links_tweets.tweet_id' => tweets)
                   .group('links.id')
                   .select('links.id, url, title, summary')
                   .select('sum(tweets.retweets) as total_retweets')
                   .select('sum(tweets.favorites) as total_favorites')
                   .order('count(links.id) desc, total_retweets desc, total_favorites desc')
  end

  def hashtags
    @hashtags ||= Hashtag.joins(:hashtags_tweets)
                         .joins(:tweets)
                         .where('hashtags_tweets.tweet_id' => tweets)
                         .group('hashtags.id')
                         .select('hashtags.id, tag')
                         .select('sum(tweets.retweets) as total_retweets')
                         .select('sum(tweets.favorites) as total_favorites')
                         .order('count(hashtags.id) desc, total_retweets desc, total_favorites desc')
  end
end
