require 'open-uri'
require 'uri'

class App < Sinatra::Base
  get "/" do
    erb :index
  end
  
  get "/fcc/:term" do
    url = "http://www.fcc.gov/search/results/" + URI.encode(params[:term])
    open(url).read
  end
  
  get "/searchusa/:term" do
    url = "https://search.usa.gov/search?&affiliate=fcc&query=" + URI.encode(params[:term])
    open(url).read
  end
end

