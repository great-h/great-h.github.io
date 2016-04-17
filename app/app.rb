# -*- coding: utf-8 -*-
require 'padrino'
require "rack-livereload"
require 'sass'
require 'slim'
require 'redcarpet'
require 'jbuilder'

module GreatHiroshima
  class App < Padrino::Application
    register ::SassInitializer
    register Padrino::Rendering
    register Padrino::Helpers
    use Rack::LiveReload unless defined?(RSpec)
    use Rack::Static, urls: ["/public"]

    set :slim, pretty: true

    def markdown(text)
      @markdown ||= begin
        options = { autolink: true, tables: true, fenced_code_blocks: true }
        Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
      end
      @markdown.render text
    end

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
        summary: Article.new("summary.markdown"),
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

    get "/event.json" do
      article = articles.last
      Jbuilder.encode do |json|
        json.no article.no.to_i
        json.datetime article.date
        json.place article.place.name
      end
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
  rescue
    STDERR.puts path
    raise
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

  def facebook
    front_matter["facebook"]
  end

  def flikr
    front_matter["flickr"]
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
    plaza_free = new(
        postcode: "7300051",
        address: "中区袋町６番３６号",
        name: "広島市まちづくり市民交流プラザ 3Fフリースペース")
    plaza_b = plaza_free.dup
    plaza_b.name = "広島市まちづくり市民交流プラザ 会議室B"
    plaza_c = plaza_free.dup
    plaza_c.name = "広島市まちづくり市民交流プラザ 会議室C"
    @places ||= {
      "tully_main_street" => new(
        postcode: "7300035",
        address: "中区本通３−９",
        name: "タリーズコーヒー広島本通店"),
      "tully_tenmaya_hattyobori" => new(
        postcode: "7308540",
        address: "広島県広島市中区胡町5-22 7F",
        name: "タリーズコーヒー天満屋八丁堀店"),
      "soa-r_seminar" => new(
        postcode: "7300803",
        address: "中区広瀬北町３－１１ 和光広瀬ビル 3F",
        name: "ソアラ ビジネスポート セミナールーム"),
      "satellite_campus_hiroshima" => new(
        postcode:"7300051",
        address: "中区大手町１丁目５−３",
        name: "サテライトキャンパスひろしま"),
      "city_hiroshima_m-plaza-freespace" => plaza_free,
      "city_hiroshima_m-plaza-meeting_b" => plaza_b,
      "city_hiroshima_m-plaza-meeting_c" => plaza_c,
      "itarian_tomate_kamiyacho" => new(
        postcode: "7300031",
        address: "中区紙屋町1-5-10紙屋町クラタビル",
        name: "イタリアン・トマト 広島紙屋町店"),
      "doutor_kinzagai" => new(
        postcode: "7300035",
        address: "広島県広島市中区本通１‐６",
        name: "ドトールコーヒーショップ 広島金座街店"),
      "doutor_kamiyacho" => new(
        postcode: "7300051",
        address: "広島県広島市中区紙屋町２‐２‐３２",
        name: "ドトールコーヒーショップ 広島紙屋町店"),
      "veloce_fukuro" => new(
        postcode: "7300036",
        address: "広島県広島市中区袋町4-21 広島ﾌｺｸ生命ﾋﾞﾙ1F",
        name: "カフェ・ベローチェ 広島袋町店"),
      "y_center-first-meeting-room" => new(
        postcode: "7300011",
        address: "広島県広島市中区基町5番61号",
        name: "広島市青少年センター 第一会議室"),
      "movin_on" => new(
        postcode: "7300021",
        address: "広島県広島市中区胡町4番25号 7F",
        name: "Movin'on"),
      "shakehands" => new(
        postcode: "7300031",
        address: "広島県広島市中区紙屋町1-4-6 アウルスタイル紙屋町 3F",
        name: "ShakeHands"),
      "internet" => new(
        name: "インターネットのどこか")
    }
    @places[key]
  end

  attr_accessor :name, :address, :postcode

  def initialize(name: name, address: address = nil, postcode: postcode = nil)
    @name = name
    @address = address
    @postcode = postcode
  end
end
