require 'date'

lib_path = File.expand_path(
  File.join(
    File.dirname(__FILE__),
    '../lib'
  )
)

if ARGV[0].nil? && ARGV[1].nil?
  print "Usage: #{$PROGRAM_NAME} date kind"
  exit 1
else
  begin
    date = Date.parse(ARGV[0])
  rescue Date::Error
    print "Invalid date"
    exit 2
  end
end

simulate = !ARGV[2].nil?

date_string = date.strftime('%Y-%m-%d')

$LOAD_PATH.unshift(lib_path)

require 'tweet_post'

tweet = TweetPost.new(date_string, ARGV[1], simulate).perform

if tweet && !simulate
  print "URI: #{tweet.uri}\n\n"
  print "Text: #{tweet.text}"
elsif tweet && simulate
  print "SIMULATE: #{tweet}"
else
  print 'No post to tweet'
  exit 3
end
