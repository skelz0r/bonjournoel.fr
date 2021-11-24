# frozen_string_literal: true

require 'abstract_unique_data_retriever'
require 'abstract_list_images'
require 'get_christmas_movie'

class ChristmasMovieUsedList < AbstractListImages
  def file_name
    'movies.txt'
  end
end

class ChristmasMovieRetriever < AbstractUniqueDataRetriever
  def used_list_class
    ChristmasMovieUsedList
  end

  def retrieve_data
    @retriever ||= GetChristmasMovie.new(page: (date.day % 5) + 1)
    @retriever.perform
  end

  def hash_to_store_in_used_list_name(item)
    item['id']
  end
end
