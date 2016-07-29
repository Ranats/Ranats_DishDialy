require 'rubygems'
require 'sinatra'
require 'erb'
require 'twitter'

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

# ハッシュタグで検索
# ツイートURLを保持？
# URLが同一な場合は追加しない．
# DBからViewを作成

client = nil

before do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['CONSUMER_KEY']
    config.consumer_secret = ENV['CONSUMER_SECRET']
  end
end

get "/" do

  query = "ｳﾎ"
  since_id = nil#dbから同期
  @result_tweets = client.search(query, count: 100, result_type: "recent", from: "Ranats85", since_id: since_id)
  erb :index
end
