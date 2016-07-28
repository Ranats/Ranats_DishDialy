require 'rubygems'
require 'sinatra'
require 'erb'

configure do
  set :protection, except: [:frame_options]
end

get "/" do
  "Hello world!"

  @src = "http://fujifilm.jp/personal/digitalcamera/x/fujinon_lens_xf16mmf14_r_wr/sample_images/img/index/ff_xf16mmf14_r_wr_004.JPG"
  erb :index
end
