class Hashtag < ActiveRecord::Base
  include Concerns::Cacheable
  include Concerns::Twitterable

  has_and_belongs_to_many :tweets

  def most_recent
    @most_recent ||= cached { twitter.search("##{tag} -rt").first }
  end
end
