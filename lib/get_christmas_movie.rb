# frozen_string_literal: true

require 'dotenv/load'
require 'tmdb'

class GetChristmasMovie
  attr_reader :page

  def initialize(page: 1)
    @page = page
    configure
  end

  def perform
    build_payload(
      get_full_movie_detail(
        elligible_movies.sample,
      )
    )
  end

  private

  def elligible_movies
    movies.reject do |movie|
      movie.adult &&
        movie.vote_count < 100
    end.sort do |movie|
      movie.vote_average
    end.take(15)
  end

  def get_full_movie_detail(movie)
    Tmdb::Movie.detail(movie.id)
  end

  def movies
    Tmdb::Keyword.movies(
      christmas_keyword_id,
      {
        page: page,
      }
    ).results
  end

  def build_payload(movie)
    {
      'id' => movie['id'],
      'name' => movie['title'],
      'url' => "https://www.themoviedb.org/movie/#{movie['id']}",
      'imdb_url' => "https://www.imdb.com/title/#{movie['imdb_id']}",
      'image_url' => "https://www.themoviedb.org/t/p/w500#{movie['poster_path']}",
    }
  end

  def configure
    Tmdb::Api.key(ENV['THE_MOVIE_DATABASE_API_KEY'])
    Tmdb::Api.language("fr")
  end

  def christmas_keyword_id
    207317
  end
end
