# frozen_string_literal: true

require 'abstract_spreadsheet'

module Backend
  class Recipes < AbstractSpreadsheet
    def tab_name
      'recettes'
    end
  end
end
