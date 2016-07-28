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

#  client.home_timeline.each do |tw|
#    puts tw.text
#  end
#  client.user_timeline("Ranats85").each do |tweet|
#    p tweet.text
#  end
end

get "/" do

  @tweet = client.user_timeline("Ranats85")
  @src = "http://fujifilm.jp/personal/digitalcamera/x/fujinon_lens_xf16mmf14_r_wr/sample_images/img/index/ff_xf16mmf14_r_wr_004.JPG"
  erb :index
end
