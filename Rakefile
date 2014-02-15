# coding: utf-8
require 'bundler/setup'
require 'thread'
require 'launchy'
require 'padrino-core/cli/rake'

PadrinoTasks.init

desc 'preview する。 http://localhost:4000/'
task :preview do
    Thread.new do
    sleep 1
    Launchy.open 'http://localhost:4000/'
  end

  sh 'bundle exec jekyll serve --watch'
end

def front_formatter(datetime, event_no)
  time_str = datetime.strftime("%Y-%m-%d %H:%M:%S %Z")
  require 'yaml'
  {
    layout: 'event',
    title: "すごい広島 ##{event_no}",
    date: time_str,
    doorkeeper: nil,
    togetter: nil,
    place: 'city_hiroshima_m-plaza-freespace',
    categories: 'events',
  }.stringify_keys.to_yaml
end

def next_event_time
  require 'active_support/core_ext'
  Date.today.beginning_of_week(:wednesday) + 1.week + 18.hours
end

def next_event_number
  @number ||= Dir
    .glob('_posts/*')
    .map { |path| path.match(/event-(\d+).markdown/) }
    .compact
    .map { |match_object| match_object[1].to_i }
    .max + 1
end

task :new_event do
  time = next_event_time
  event_no = '%03d' % next_event_number
  filename = time.strftime("_posts/%Y-%m-%d-event-#{event_no}.markdown")
  open(filename, 'w') do |io|
    io.print front_formatter(time, next_event_number)
    io.puts <<-STRING
---

# 参加者
STRING
  end

  require 'json'
  json = {
          no: next_event_number,
          datetime: next_event_time
         }.to_json
  open('event.json', 'w') do |io|
    io.puts(json)
  end
end
