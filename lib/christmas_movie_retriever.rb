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
    @retriever ||= ::Backend::ChristmasMovies.new.data
    @retriever.sample
  end

  def hash_to_store_in_used_list_name(item)
    item['url']
  end
end
