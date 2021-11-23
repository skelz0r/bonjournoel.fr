# frozen_string_literal: true

require 'abstract_unique_data_retriever'
require 'abstract_list_images'
require 'get_christmas_tree'

class ChristmasTreeUsedList < AbstractListImages
  def file_name
    'trees.txt'
  end
end

class ChristmasTreeRetriever < AbstractUniqueDataRetriever
  def used_list_class
    ChristmasTreeUsedList
  end

  def retrieve_data
    @retriever ||= GetChristmasTree.new(page: date.day).images
    @retriever.sample
  end

  def hash_to_store_in_used_list_name(item)
    item['urls']['regular']
  end
end
