# frozen_string_literal: true

class GenerateContentsData
  def perform
    create_file_if_not_exists!
    File.open(final_data_path, 'w') { |f| f.write posts_data.to_yaml }
  end

  private

  def create_file_if_not_exists!
    return if File.exist?(final_data_path)
    File.write(final_data_path, '')
  end

  def posts_data_sanitized
    posts_data.map do |post_data|
      post_data.except(
        'layout'
      )
    end
  end

  def final_data_path
    file_path(
      "../_data/all_posts_data.yml"
    )
  end

  def posts_data
    posts.map do |post|
      YAML.load_file(post)
    end.sort do |p1, p2|
      p1['date'] <=> p2['date']
    end
  end

  def posts
    Dir[file_path('../_posts/*.md')]
  end

  def file_path(path)
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        path
      )
    )
  end
end
