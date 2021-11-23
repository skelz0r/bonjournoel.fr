require 'date'
require 'liquid'

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
      'date' => date.to_time.to_s,

      'christmas_tree_image_url' => christmas_tree_image_url,
      'spotify_track_id' => spotify_track_id,
      'debat' => debat,

      'gift' => gift_properties,
      'recipe' => recipe_properties,
    }
    rendered_template = template.render(variables)

    File.open(final_post_path, 'w') { |f| f.write(rendered_template) }
  end

  def symlink_today_post_to_index
    File.delete(
      file_path('../index.html')
    )

    File.symlink(
      final_post_path,
      file_path('../index.html')
    )
  end

  private

  def christmas_tree_image_url
    'https://i0.wp.com/cestquoicebruit.com/wp-content/uploads/2018/12/sapin-noel-deco-addict.png'
  end

  def spotify_track_id
    '0bYg9bo50gSsH3LtXe2SQn'
  end

  def debat
    "Comment dire à son oncle qu'il est un peu trop saoul ?"
  end

  def gift_properties
    {
      'url' => 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'name' => 'Auto cuiseur à riz',
      'image_url' => 'https://www.maspatule.com/11691-30939-thickbox/cuiseur-a-riz-1l-bestron.jpg',
    }
  end

  def recipe_properties
    {
      'name' => "La véritable tartiflette de Noël",
      'url' => 'https://www.marmiton.org/recettes/recette_la-vraie-tartiflette_17634.aspx',
      'image_url' => 'https://assets.afcdn.com/recipe/20160401/38946_w1024h768c1cx2690cy1793.jpg',
    }
  end

  def post_template
    file_path(
      '../templates/post.md'
    )
  end

  def final_post_path
    file_path(
      "../_posts/#{date_formatted}-jour-#{date.day}.md",
    )
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
end
