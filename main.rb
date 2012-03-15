require 'open-uri'
require 'uri'
require 'nokogiri'

class App < Sinatra::Base
  
  def insert_absolute_path(url, base)
    html = open(url).read
    doc = Nokogiri::HTML html
    doc.xpath("html/head/link").each do |link|
      uri = link.attributes["href"]
      uri.value = base + uri.value
    end
    
    str1 = "/sites/all/themes/fcc/images/logoFCC1.jpg"
    rplc1 = base + str1
    
    str2 = "/sites/all/themes/fcc/images/logoFCC2.jpg"
    rplc2 = base + str2
    
    doc = doc.to_s.gsub(str1, rplc1)
    doc.gsub(str2, rplc2)
  end
  
  get "/" do
    erb :index
  end
  
  get "/fcc/:term" do
    url = "http://www.fcc.gov/search/results/" + URI.encode(params[:term])
    doc = insert_absolute_path(url, "http://fcc.gov")
    
    doc
  end
  
  get "/searchusa/:term" do
    url = "https://search.usa.gov/search?&affiliate=fcc&query=" + URI.encode(params[:term])
    doc = insert_absolute_path(url, "https://search.usa.gov")
    doc
  end

end