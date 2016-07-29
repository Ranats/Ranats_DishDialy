require 'rubygems'
require 'sinatra'
require 'erb'
require 'twitter'

require 'pg'

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'sqlite3://localhost/myapp.db')

class Count < ActiveRecord::Base; end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module Twitter
  class SearchResults
    def next_page
      return nil unless next_page?
      hash = query_string_to_hash(@attrs[:search_metadata][:next_results])
      since_id = @attrs[:search_metadata][:since_id]
      hash[:since_id] = since_id unless since_id.zero?
      hash
    end

  end
end

configure do
  set :protection, except: [:frame_options]
end

before do
  $client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['CONSUMER_KEY']
    config.consumer_secret = ENV['CONSUMER_SECRET']
  end
end

get "/" do
  query = params['query']
  p query
  since_id = 600052234543013889#dbから同期 このid以降のツイートを取得
  @result_tweets = []
    begin
      tmp_result = $client.search(query, count: 100, from: "Ranats85", since_id: since_id)
      @result_tweets += tmp_result.to_a unless tmp_result.first.nil?
      break if @result_tweets.length > 100
    rescue Twitter::Error::TooManyRequests => error
      p error.rate_limit.reset_in
      sleep error.rate_limit.reset_in
      retry
    end

  i = 0
  @result_tweets.each do |tweet|
    p tweet.id
  end
  erb :index
end
