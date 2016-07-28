require 'rubygems'
require 'sinatra'

get "/" do
  "Hello world!"

  @item = "http://fujifilm.jp/personal/digitalcamera/x/fujinon_lens_xf16mmf14_r_wr/sample_images/img/index/ff_xf16mmf14_r_wr_004.JPG"
  @item.image.body
end
