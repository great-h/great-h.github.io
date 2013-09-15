# coding: utf-8
require 'bundler/setup'
require 'thread'
require 'launchy'

desc 'preview する。 http://localhost:4000/'
task :preview do
    Thread.new do
    sleep 1
    Launchy.open 'http://localhost:4000/'
  end

  sh 'bundle exec jekyll serve --watch'
end
