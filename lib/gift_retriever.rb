# frozen_string_literal: true

require 'backend'
require 'abstract_unique_data_retriever'
require 'abstract_list_images'

class GiftUsedList < AbstractListImages
  def file_name
    'gifts.txt'
  end
end

class GiftRetriever < AbstractUniqueDataRetriever
  def used_list_class
    GiftUsedList
  end

  def retrieve_data
    @retriever ||= ::Backend::Gifts.new.data
    @retriever.sample
  end

  def hash_to_store_in_used_list_name(item)
    item['url']
  end
end
