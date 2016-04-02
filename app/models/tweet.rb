class Tweet < ActiveRecord::Base
  include Concerns::Twitterable

  belongs_to :user
  has_and_belongs_to_many :links
  has_and_belongs_to_many :hashtags

  def self.import!(user, tweet)
    hashtags = tweet.hashtags.map do |hashtag|
      Hashtag.where(tag: hashtag.text).first_or_create!
    end
    links = tweet.urls.map do |url|
      Link.import! url.expanded_url
    end.compact
    where(identifier: tweet.id).first_or_create!(
      user: user,
      posted_at: tweet.created_at,
      hashtags: hashtags,
      links: links,
      retweets: tweet.retweet_count,
      favorites: tweet.favorite_count
    )
  end

  def full
    @full ||= twitter.status(identifier)
  end
end
