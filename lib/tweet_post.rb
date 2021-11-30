# frozen_string_literal: true

require 'dotenv/load'
require 'twitter'

require 'open-uri'
require 'yaml'
require 'liquid'
require 'date'
require 'spintax_parser'

class String
  include SpintaxParser
end

class TweetPost
  attr_reader :date,
    :kind,
    :simulate

  def initialize(date, kind, simulate)
    @date = Date.parse(date)
    @kind = kind
    @simulate = simulate
  end

  def perform
    return unless post_exists?
    return text if simulate

    if image?
      client.update_with_media(
        text,
        URI.open(image_url)
      )
    else
      client.update(text)
    end
  end

  def text
    template = Liquid::Template.parse(File.read(template_path))
    template.render(variables).strip.unspin
  end

  def image_url
    template = Liquid::Template.parse(File.read(template_image_path))
    template.render(variables).strip.unspin
  end

  private

  def image?
    File.exist?(template_image_path)
  end

  def variables
    YAML.load_file(final_post_path)
  end

  def post_exists?
    File.exist?(final_post_path)
  end

  def template_image_path
    absolute_file_path(
      "../templates/tweets/#{kind}.image.txt",
    )
  end

  def template_path
    absolute_file_path(
      "../templates/tweets/#{kind}.txt",
    )
  end

  def final_post_path
    absolute_file_path(
      "../_posts/#{final_post_name}"
    )
  end

  def final_post_name
    "#{date_dashed}-jour-#{date.day}.md"
  end

  def date_dashed
    @date_dashed ||= date.strftime('%Y-%m-%d')
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def absolute_file_path(path)
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        path
      )
    )
  end
end
