require 'nokogiri'
require 'open-uri'

class SearchesController < ApplicationController

  def search
  end

def goodreads
  @resp = Faraday.get 'https://www.goodreads.com/search/index.xml' do |req|
    req.params['key'] = 'dOv4GIHVoXiC0HIj7jwA'
    # req.params['client_secret'] = client_secret
    req.params['q'] = params[:title]

  end
  # @doc  = Nokogiri::XML(@resp.body)
  # @doc.xpath("//work").each do |work|
  #   [best_book].each do |n|
  #     puts work.at(n).text
  #   end
  # end
  xml = Nokogiri::XML(@resp.body)
  # @books = xml.search('work').map do |book|
  #   %w[
  #     id average_rating best_book
  #   ].each_with_object({}) do |n, o|
  #     o[n] = book.at(n).text
  #
  #   end
  # end
  #
  # puts @books.size
  @books = []
  xml.search("best_book").map do |w|

      @books << w.xpath("title").text

end
@books


  render 'search'
end

end
