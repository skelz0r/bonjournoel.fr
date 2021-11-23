# frozen_string_literal: true

require 'backend'
require 'abstract_unique_data_retriever'
require 'abstract_list_images'

class RecipeUsedList < AbstractListImages
  def file_name
    'recipes.txt'
  end
end

class RecipeRetriever < AbstractUniqueDataRetriever
  def used_list_class
    RecipeUsedList
  end

  def retrieve_data
    ::Backend::Recipes.new.data.sample
  end

  def hash_to_store_in_used_list_name(item)
    item['url']
  end
end
