# frozen_string_literal: true

require 'json'

require 'dotenv/load'
require 'rest-client'

class GetChristmasTree
  def initialize(page: 1)
    @page = page
  end

  def images
    response = RestClient::Request.execute(
      method: :get,
      url: search_photo_url,
      headers: {
        'Authorization' => "Client-ID #{ENV['UNSPLASH_ACCESS_KEY']}",
        params: {
          query: 'christmas tree',
          orientation: 'portrait',
          per_page: 30,
          page: page,
        }
      }
    )

    if response.code == 200
      json = JSON.parse(response.body)
      json['results']
    end
  end

  private

  def max_results
    10_000
  end

  def search_photo_url
    'https://api.unsplash.com/search/photos'
  end
end
