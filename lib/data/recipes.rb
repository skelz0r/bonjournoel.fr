# frozen_string_literal: true

require 'abstract_spreadsheet'
require 'data'

class Data::Recipes < AbstractSpreadsheet
  def tab_name
    'recettes'
  end
end
