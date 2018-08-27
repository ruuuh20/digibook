require 'nokogiri'
require 'open-uri'
require 'pry'

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
  # @books = []

#   xml.search("best_book").map do |w|
#
#       @books << w.xpath("title", "id").text
#
# end
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

# @array = []
# xml.search("work").map do |x|
#   hash = {}
#   x.attributes.each do |attribute| # loop through all attributes in the matches found
#     hash[attribute[1].name.to_sym] = attribute[1].value
#   end
#   @array << hash
# end


  render 'search'
end

end
