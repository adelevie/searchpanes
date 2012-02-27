require 'open-uri'

class App < Sinatra::Base
  get "/" do
    erb :index
  end
  
  get "/google/:term" do
    url = "http://google.com/?q=" + params[:term] + "#output=search&q=" + params[:term]
    open(url).read
  end
  
  get "/bing/:term" do
    url = "http://bing.com/search?q=" + params[:term] + "&go=&qs=n&form=QBLH&pq=hello&sc=8-5&sp=-1&sk="
    open(url).read
  end
end