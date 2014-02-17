require File.expand_path("../../config/boot.rb", __FILE__)
require 'sitespec'
require './app/app'
require 'pry'

Sitespec.configure do
  self.application = GreatHiroshima::App.new
  self.build_path = "_site/"
  self.raise_http_error = true
end

describe "Sitespec" do
  include Sitespec

  it "generate main page" do
    get "/index.html"
    get "/rule.html"
    get "/archives.html"
    get "/stylesheets/application.css"
    get "/event.json"
    get "/google1f4a02fe0a1f18ac.html"
  end

  it "generate event page" do
    Dir.glob('_posts/*.markdown').each do |filepath|
      event_no = filepath.match(/_posts\/.*event-(.+)\.markdown/)[1]
      path = "/events/event-#{event_no}.html"
      get path
    end
  end
end
