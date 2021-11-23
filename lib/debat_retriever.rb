# frozen_string_literal: true

require 'backend'
require 'abstract_unique_data_retriever'
require 'abstract_list_images'

class DebatUsedList < AbstractListImages
  def file_name
    'debats.txt'
  end
end

class DebatRetriever < AbstractUniqueDataRetriever
  def used_list_class
    DebatUsedList
  end

  def retrieve_data
    @retriever ||= ::Backend::Debats.new.data
    @retriever.sample
  end

  def hash_to_store_in_used_list_name(item)
    item['content']
  end
end
