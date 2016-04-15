require File.expand_path("../../config/boot.rb", __FILE__)
require "sitespec/rspec"
require './app/app'
require 'pry'

Sitespec.configuration.build_path = "_site/"

describe "Sitespec", :sitespec do
  let(:app) do
    GreatHiroshima::App
  end

  it "generate main page" do
    get "/index.html"
    get "/rule.html"
    get "/archives.html"
    get "/stylesheets/application.css"
    get "/javascripts/application.js"
    get "/event.json"
    get "/google1f4a02fe0a1f18ac.html"
    `mkdir -p _site/img`
    `cp public/img/main.jpg _site/img`
  end

  it "generate event page" do
    Dir.glob('_posts/*.markdown').each do |filepath|
      event_no = filepath.match(/_posts\/.*event-(.+)\.markdown/)[1]
      path = "/events/event-#{event_no}.html"
      get path
    end
  end
end
