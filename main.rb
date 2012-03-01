require 'open-uri'
require 'uri'
require 'nokogiri'

class App < Sinatra::Base
  get "/" do
    erb :index
  end
  
  def insert_absolute_path(url, base)
    html = open(url).read
    doc = Nokogiri::HTML html
    links = doc.xpath("html/head/link")
    links.each do |link|
      link.attributes["href"].value = base + link.attributes["href"].value
    end
    
    doc
  end
  
  get "/fcc/:term" do
    url = "http://www.fcc.gov/search/results/" + URI.encode(params[:term])
    doc = insert_absolute_path(url, "http://fcc.gov")
    doc.to_s
  end
  
  get "/searchusa/:term" do
    url = "https://search.usa.gov/search?&affiliate=fcc&query=" + URI.encode(params[:term])
    doc = insert_absolute_path(url, "https://search.usa.gov")
    doc.to_s
  end
end

