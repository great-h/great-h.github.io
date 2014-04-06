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

    set :slim, pretty: true
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
        articles: articles.reverse[0..4]
      }
    end

    get "/events/event-:no.html" do |no|
      slim :event, locals: {
        article: articles_table[no],
      }
    end

    get "/rule.html" do
      slim :default, locals: { article: Article.new("rule.markdown") }
    end

    get "/archives.html" do
      slim :archives, locals: { articles: articles }
    end

    def articles_table
      unless @articles
        @articles = {}

        Dir.glob('_posts/*.markdown').map do |filepath|
          article = Article.new(filepath)
          @articles[article.no] = article
        end
      end
      @articles
    end

    def articles
      articles_table.values.sort_by { |a| a.date }
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

  def place
    Place.find(front_matter["place"])
  end

  def atnd_type
    return @atnd_type if @atnd_type

    @atnd_type = "none"
    keys = front_matter.keys
    %W|atnd localsearch doorkeeper|.each do |type|
      if keys.include? type
        @atnd_type = type
        break
      end
    end
    @atnd_type
  end

  def atnd_url
    return if atnd_type == "none"
    front_matter[atnd_type]
  end

  def togetter
    front_matter["togetter"]
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

class Place
  def self.find(key)
    @places ||= {
      "tully_main_street" => new(
        postcode: "7300035",
        address: "中区本通３−９",
        name: "タリーズコーヒー広島本通店"),
      "soa-r_seminar" => new(
        postcode: "7300803",
        address: "中区広瀬北町３－１１ 和光広瀬ビル 3F",
        name: "ソアラ ビジネスポート セミナールーム"),
      "satellite_campus_hiroshima" => new(
        postcode:"7300051",
        address: "中区大手町１丁目５−３",
        name: "サテライトキャンパスひろしま"),
      "city_hiroshima_m-plaza-freespace" => new(
        postcode: "7300051",
        address: "中区袋町６番３６号",
        name: "広島市まちづくり市民交流プラザ 3Fフリースペース"),
      "itarian_tomate_kamiyacho" => new(
        postcode: "7300031",
        address: "中区紙屋町1-5-10紙屋町クラタビル",
        name: "イタリアン・トマト 広島紙屋町店"),
      "doutor_kinzagai" => new(
        postcode: "7300035",
        address: "広島県広島市中区本通１‐６",
        name: "ドトールコーヒーショップ 広島金座街店"),
      "internet" => new(
        name: "インターネットのどこか")
    }
    @places[key]
  end

  attr_reader :name, :address, :postcode

  def initialize(name: name, address: address = nil, postcode: postcode = nil)
    @name = name
    @address = address
    @postcode = postcode
  end
end
