require 'padrino'
require 'sass'
require 'slim'

module GreatHiroshima
  class App < Padrino::Application
#    register SassInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    get "/index.html" do
#      slim :index, locals: { articles: articles }
      "hoge"
    end

    helpers do
      def artciles
        []
      end
    end
  end
end
