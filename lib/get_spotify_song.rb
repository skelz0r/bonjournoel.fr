# frozen_string_literal: true

require 'dotenv/load'
require 'rspotify'

class GetSpotifySong
  def initialize
    authenticate
  end

  def perform
    tracks.sample
  end

  def tracks
    @tracks ||= RSpotify::Track.search(
      'christmas',
      {
        market: 'FR',
        limit: 10,
        offset: 500,
      },
    )
  end

  private

  def authenticate
    RSpotify.authenticate(
      ENV['SPOTIFY_CLIENT_ID'],
      ENV['SPOTIFY_CLIENT_SECRET'],
    )
  end

  def max_offset
    800
  end
end
