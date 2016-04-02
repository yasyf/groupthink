module Concerns
  module Twitterable
    extend ActiveSupport::Concern

    class_methods do
      def twitter
        @twitter ||= Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV['CONSUMER_KEY']
          config.consumer_secret     = ENV['CONSUMER_SECRET']
          config.access_token        = ENV['ACCESS_TOKEN']
          config.access_token_secret = ENV['ACCESS_SECRET']
        end
      end
    end

    private

    def twitter
      self.class.twitter
    end
  end
end
