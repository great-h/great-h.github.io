require 'padrino'
require "rack-livereload"
require 'sass'
require 'slim'
require 'redcarpet'

module GreatHiroshima
  class App < Padrino::Application
    register ::SassInitializer
    register Padrino::Rendering
    register Padrino::Helpers
    use Rack::LiveReload unless defined?(RSpec)
    use Rack::Static, urls: ["/public"]

    set :markdown, fenced_code_blocks: true

    enable :reloader
    disable :logging if defined?(RSpec)

    get "/stylesheets/application.css" do
      content_type "text/css"
      scss :application
    end

    get "/" do
      redirect_to "/index.html"
    end

    get "/index.html" do
      slim :index, locals: {
        article: Article.new("index.markdown"),
        articles: recent
      }
    end

    get "/events/event-:no.html" do |no|
      slim :event, locals: {
        article: articles[no],
      }
    end

    get "/rule.html" do
      slim :default, locals: { article: Article.new("rule.markdown") }
    end

    get "/archives.html" do
      slim :archives, locals: { articles: articles.values }
    end

    def articles
      unless @articles
        @articles = {}

        Dir.glob('_posts/*.markdown').map do |filepath|
          article = Article.new(filepath)
          @articles[article.no] = article
        end
      end
      @articles
    end

    def recent
      articles.keys.reverse[0..4].map do |key|
        articles[key]
      end
    end
  end
end

class Article
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def no
    path.match(/_posts\/.*event-(.+)\.markdown/)[1]
  end

  def title
    front_matter["title"]
  end

  def date
    @date ||= DateTime.parse(front_matter["date"])
  end

  def body
    front_matter_and_body[1]
  end

  def front_matter
    front_matter_and_body[0]
  end

  def front_matter_and_body
    @front_matter_and_body ||= begin
      matters = {}
      content = File.read(path).sub(/\A(---\s*\n.*?\n?)^---\s*$\n?/m) do
        matters = YAML.load($1)
        ""
      end
      [matters, content]
    end
  end
end
