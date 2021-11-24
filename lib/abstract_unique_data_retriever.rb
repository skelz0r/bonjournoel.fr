# frozen_string_literal: true

class AbstractUniqueDataRetriever
  attr_reader :date

  class NoDataAvailable < StandardError; end

  def initialize(date)
    @date = date
  end

  def get
    data = nil
    i = 0

    loop do
      i = i+1
      data = retrieve_data

      break unless used_list_instance.include?(hash_to_store_in_used_list_name(data))
      raise NoDataAvailable.new("#{self.class.name}: Try to fetch data #{i} times, there is an issue") if i == 100
    end

    used_list_instance.add(hash_to_store_in_used_list_name(data))

    data
  end

  protected

  def retrieve_data
    fail NotImplementedError
  end

  def used_list_class
    fail NotImplementedError
  end

  def hash_to_store_in_used_list_name(item)
    fail NotImplementedError
  end

  private

  def used_list_instance
    @used_list_instance ||= used_list_class.instance
  end
end
