class User < ActiveRecord::Base
  include Concerns::Cacheable
  include Concerns::Twitterable

  has_many :tweets

  def self.import!(user)
    user = twitter.user(user) if user.is_a?(String)
    where(username: user.screen_name).first_or_create!(identifier: user.id, name: user.name)
  end

  def oldest_tweet
    @oldest_tweet ||= tweets.order(:identifier).first
  rescue Twitter::Error::Unauthorized
    nil
  end

  def newest_tweet
    @newest_tweet ||= tweets.order(identifier: :desc).first
  rescue Twitter::Error::Unauthorized
    nil
  end

  def sync(oldest = 2.weeks.ago, newest = DateTime.now, count = 200)
    options = { include_rts: false, exclude_replies: true, count: count }
    if newest > self.newest
      self.newest = newest
    else
      options[:max_id] = newest_tweet.identifier if newest_tweet
    end
    if oldest < self.oldest
      self.oldest = oldest
    else
      options[:since_id] = oldest_tweet.identifier if oldest_tweet
    end
    save!
    twitter.user_timeline(username, options).each do |tweet|
      Tweet.import! self, tweet
    end
  rescue Twitter::Error::Unauthorized
    nil
  end

  def full
    @full ||= cached { twitter.user(username) }
  end
end
