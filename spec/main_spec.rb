require File.expand_path("../../config/boot.rb", __FILE__)
require "sitespec/rspec"
require './app/app'
require 'pry'

Sitespec.configuration.build_path = "_site/"

describe "Sitespec", :sitespec do
  let(:app) do
    GreatHiroshima::App
  end
  ["/index.html", "/rule.html", "/archives.html", "/stylesheets/application.css",  "/javascripts/application.js", "/event.json", "/google1f4a02fe0a1f18ac.html"].each do |path|
    it "generate page: #{path}" do
      get path
    end
  end

  Dir.glob('_posts/*.markdown').each do |filepath|
    it "generate event page #{filepath}" do
      event_no = filepath.match(/_posts\/.*event-(.+)\.markdown/)[1]
      path = "/events/event-#{event_no}.html"
      get path
    end
  end
end
