require 'rubygems'
require 'sinatra'
require 'erb'
require 'twitter'

configure do
  set :protection, except: [:frame_options]
end

# ハッシュタグで検索
# ツイートURLを保持？
# URLが同一な場合は追加しない．
# DBからViewを作成

before do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['CONSUMER_KEY']
    config.consumer_secret = ENV['CONSUMER_SECRET']
    config.access_token = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end

  client.user_timeline("Ranats85").each do |tweet|
    p tweet.text
  end
end

get "/" do


  @src = "http://fujifilm.jp/personal/digitalcamera/x/fujinon_lens_xf16mmf14_r_wr/sample_images/img/index/ff_xf16mmf14_r_wr_004.JPG"
  erb :index
end
