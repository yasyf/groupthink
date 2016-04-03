class Link < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  EXCLUDES = %w(twitter.com).flat_map { |host| [host, "www.#{host}"] }
  EXCEPTIONS = %w(youtube.com facebook.com).flat_map { |host| [host, "www.#{host}"] }

  def self.import!(uri)
    uri = expand(uri)
    return nil unless uri.present?
    return nil if EXCLUDES.include? uri.host
    found = where(url: uri.to_s).first
    return found if found.present?
    return nil unless summary = summarize(uri.to_s)
    where(url: uri.to_s).first_or_create! summary
  end

  def self.expand(uri)
    HTTParty.head(uri).request.last_uri.tap do |u|
      unless EXCEPTIONS.include?(u.host)
        u.fragment = u.query = nil
      end
    end
  rescue
    nil
  end

  def self.summarize(url)
    query = { url: url, output: :json }
    result = HTTParty.get('http://textteaser.com/summary', query: query).parsed_response
    return nil if result['error'].present?
    return nil unless result['sentences'].present?
    return nil unless sentence = result['sentences'].sort { |s| s['totalScore'] }
    { summary: sentence.first(2).map { |s| s['sentence'] }.join(' '), title: result['title'] }
  end
end
