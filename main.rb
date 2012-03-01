require 'open-uri'
require 'uri'
require 'nokogiri'

class App < Sinatra::Base
  get "/" do
    erb :index
  end
  
  def insert_absolute_path(url)
    html = open(url).read
    doc = Nokogiri::HTML html
    links = doc.xpath("html/head/link")
    links.each do |link|
      link.attributes["href"].value = "http://fcc.gov" + link.attributes["href"].value
    end
    
    doc
  end
  
  get "/fcc/:term" do
    url = "http://www.fcc.gov/search/results/" + URI.encode(params[:term])
    #open(url).read
    doc = insert_absolute_path url
    doc.to_s
  end
  
  get "/searchusa/:term" do
    url = "https://search.usa.gov/search?&affiliate=fcc&query=" + URI.encode(params[:term])
    open(url).read
  end
  
  get "/foo" do
    url = "http://www.fcc.gov/search/results/" + URI.encode(params[:term])
    #open(url).read
    doc = insert_absolute_path url
  end
end

