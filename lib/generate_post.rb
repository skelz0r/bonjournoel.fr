require 'date'
require 'liquid'

require 'christmas_tree_retriever'
require 'christmas_movie_retriever'
require 'gift_retriever'
require 'debat_retriever'
require 'recipe_retriever'
require 'spotify_song_retriever'

class GeneratePost
  attr_reader :date

  def initialize(date)
    @date = date
  end

  def perform
    create_post
    symlink_today_post_to_index
  end

  def create_post
    template = Liquid::Template.parse(File.read(post_template))
    variables = {
      'number' => date.day,
      'countdown' => christmas_day.yday - date.yday,
      'date' => (date.to_time + 2*60 + 10).to_s,

      'christmas_tree_image_url' => christmas_tree_image_url,
      'spotify_track_id' => spotify_track_id,
      'debat' => debat,

      'gift' => gift_properties,
      'recipe' => recipe_properties,
      'movie' => christmas_movie_properties,
    }
    rendered_template = template.render(variables)

    File.open(final_post_path, 'w') { |f| f.write(rendered_template) }
  end

  def symlink_today_post_to_index
    File.delete(
      file_path('../index.html')
    )

    Dir.chdir(file_path('../')) do
      File.symlink(
        "_posts/#{final_post_name}",
        'index.html'
      )
    end
  end

  private

  def christmas_tree_image_url
    ChristmasTreeRetriever.new(date).get['urls']['regular']
  end

  def spotify_track_id
    SpotifySongRetriever.new(date).get.id
  end

  def debat
    DebatRetriever.new(date).get['content']
  end

  def gift_properties
    GiftRetriever.new(date).get
  end

  def recipe_properties
    RecipeRetriever.new(date).get
  end

  def christmas_movie_properties
    ChristmasMovieRetriever.new(date).get
  end

  def post_template
    file_path(
      '../templates/post.md'
    )
  end

  def final_post_path
    file_path(
      "../_posts/#{final_post_name}"
    )
  end

  def final_post_name
    "#{date_formatted}-jour-#{date.day}.md"
  end

  def file_path(path)
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        path
      )
    )
  end

  def date_formatted
    date.strftime('%Y-%m-%d')
  end

  def christmas_day
    Date.new(2021, 12, 25)
  end
end
