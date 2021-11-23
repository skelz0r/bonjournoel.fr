# frozen_string_literal: true

class AbstractUniqueDataRetriever
  attr_reader :date

  def initialize(date)
    @date = date
  end

  def get
    data = nil

    # FIXME infinite loop
    loop do
      data = retrieve_data

      break unless used_list_instance.include?(hash_to_store_in_used_list_name(data))
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
