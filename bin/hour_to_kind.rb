# frozen_string_literal: true

require 'time'

hour = Time.now.hour

print case hour
when (8..9)
  :sapin
when (10..11)
  :debat
when (12..13)
  :gift
when (14..15)
  :spotify
when (16..17)
  :recipe
when (18..19)
  :movie
else
  raise 'Not valid'
end
