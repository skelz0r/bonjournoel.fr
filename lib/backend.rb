# frozen_string_literal: true

require 'abstract_spreadsheet'

module Backend
  class Recipes < AbstractSpreadsheet
    def tab_name
      'recettes'
    end
  end

  class Debats < AbstractSpreadsheet
    def tab_name
      'debats'
    end
  end

  class Gifts < AbstractSpreadsheet
    def tab_name
      'cadeaux'
    end
  end
end
