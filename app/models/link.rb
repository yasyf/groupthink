class Link < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  EXCLUDES = %w(twitter.com)

  def self.import!(uri)
    found = where(url: uri.to_s).first
    return found if found.present?
    return nil if EXCLUDES.include? uri.host
    return nil unless summary = summarize(uri.to_s)
    where(url: uri.to_s).first_or_create! summary
  end

  def self.summarize(url)
    query = { url: url, output: :json }
    result = HTTParty.get('http://textteaser.com/summary', query: query).parsed_response
    return nil if result['error'].present?
    return nil unless sentence = result['sentences'].find { |s| s['order'] == 0 }
    { summary: sentence['sentence'], title: result['title'] }
  end
end
