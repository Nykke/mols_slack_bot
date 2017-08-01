require 'slack-ruby-bot'
require 'httparty'

class Bot < SlackRubyBot::Bot
  #
  # BASE_URL = 'https://www.reddit.com'
  # SUBREDDIT_BASE_URL = BASE_URL+'/r/'
  # DEFAULT_LIMIT = 10

  match /^mols (?<size>\w*)$/ do |client, data, match|
    # client.say(channel: data.channel, text: "Computing orthogonal squares of size #{match[:size]}x#{match[:size]}. Will post in latin_squares channel")
    command = "docker service create \
    --constraint node.role==worker
    --limit-cpu 2.5 \
    --no-resolve-image \
    --restart-condition none \
    --name latin_squares champain/latin_squares:mols_bot \
    #{match[:size]} https://hooks.slack.com/services/#{ENV['MOLS_SLACK_API_KEY']}"
    system(command)
  end


#
#   command 'list' do |client, data, _match|
#     input = parse_input(_match)
#     url = build_url(input[:sub_reddit], input[:limit])
#     posts_data = fetch_posts(url)
#
#     if posts_data.any?
#       client.web_client.chat_postMessage(channel: data.channel, text: "Here it is: \n #{build_post_list(posts_data)}")
#     else
#       client.say(channel: data.channel, text: 'SubReddit does not seem to exist...', gif: 'sad')
#     end
#   end
#
#   class << self
#     def parse_input(_match)
#       input = _match[:expression].split(' ')
#       limit = input.last if input[1] && input[1].to_i.to_s == input[1]
#       {
#         sub_reddit: input.first,
#         limit: limit || DEFAULT_LIMIT
#       }
#     end
#
#     def build_url(sub_reddit, post_limit)
#       "#{SUBREDDIT_BASE_URL}#{sub_reddit}.json?limit=#{post_limit}"
#     end
#
#     def fetch_posts(url)
#       response = HTTParty.get(url)
#       response.parsed_response['data']['children']
#     end
#
#     def build_post_list(posts)
#       posts.map { |post| build_post_text(post['data']) }.join("\n")
#     end
#
#     def build_post_text(post)
#       text = "<#{BASE_URL}#{post['permalink']} | #{post['title']}>"
#       text = text + " | post <#{post['url']} | source>" unless post['permalink'] == post['url']
#       text
#     end
#   end
end

SlackRubyBot::Client.logger.level = Logger::WARN

Bot.run
