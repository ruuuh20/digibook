require 'nokogiri'

class SearchesController < ApplicationController

  def search
  end

def goodreads
  @resp = Faraday.get 'https://www.goodreads.com/search/index.xml' do |req|
    req.params['key'] = 'dOv4GIHVoXiC0HIj7jwA'
    # req.params['client_secret'] = client_secret
    req.params['q'] = params[:title]

  end
  @doc  = Nokogiri::XML(@resp.body)
  @doc = @doc.xpath("//work").text



  render 'search'
end

end
