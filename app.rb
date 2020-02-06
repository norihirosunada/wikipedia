require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'net/http'
require 'uri'

get '/' do 
    base_url = 'http://wikipedia.simpleapi.net/api?output=html&keyword='
    if params[:keyword]
        keyword = URI.escape(params[:keyword])
        url = URI.parse(base_url+keyword)
        if Net::HTTP.get(url) != ""
            @result = Net::HTTP.get(url).force_encoding("utf-8")
        else
            @result = "params[:keyword]がありません。"
        end
    end
    erb :index
end

