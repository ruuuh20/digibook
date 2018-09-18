require 'nokogiri'
require 'open-uri'
require 'pry'

class SearchesController < ApplicationController

  def search
  end

def goodreads
  @resp = Faraday.get 'https://www.goodreads.com/search/index.xml' do |req|
    req.params['key'] = ENV['GOODREADS_KEY']
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
  # @books = []

#   xml.search("best_book").map do |w|
#
#       @books << w.xpath("title", "id").text
#
# end

# use this one
@new_array = []

  xml.search("best_book").each do |book|
    hash = {}
    hash[:title] = book.xpath("title").text
    hash[:id] = book.xpath('id').text
    hash[:small_img] = book.xpath('small_img_url').text
    hash[:author] = book.xpath('author').xpath('name').text
    # binding.pry
    @new_array  << hash
end
  render 'search'
end


def google_books
  @resp = Faraday.get 'https://www.googleapis.com/books/v1/volumes?' do |req|
    req.params['key'] = ENV['GOOGLE_KEY']

    req.params['q'] = params[:title]
  end

    body_hash = JSON.parse(@resp.body)
    @books = body_hash["items"]

    render 'search'


end

def book
  
end

end
