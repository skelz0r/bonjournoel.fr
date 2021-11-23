# frozen_string_literal: true

require 'base64'

require 'abstract_unique_data_retriever'
require 'abstract_list_images'
require 'get_spotify_song'

class SpotifyUsedList < AbstractListImages
  def file_name
    'spotify_song.txt'
  end
end

class SpotifySongRetriever < AbstractUniqueDataRetriever
  def used_list_class
    SpotifyUsedList
  end

  def retrieve_data
    @retriever ||= GetSpotifySong.new(limit: 50, offset: date.day * 10)
    @retriever.perform
  end

  def hash_to_store_in_used_list_name(track)
    key = track.artists.map do |a|
      a.name
    end.to_json

    Base64.encode64(key)
  end
end
