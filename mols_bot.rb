require 'slack-ruby-bot'
require 'httparty'

class Bot < SlackRubyBot::Bot

  match /^mols (?<size>-?\w*)$/ do |client, data, match|
    if match[:size].to_i < 1
      client.say(channel: data.channel, text: "Sorry, the size of #{match[:size]}x#{match[:size]} is invalid.")
    elsif match[:size].to_i == 6
      client.say(channel: data.channel, text: "Sorry, there are no latin squares of size #{match[:size]}x#{match[:size]}.")
    elsif match[:size].to_i > 10
      client.say(channel: data.channel, text: "Sorry, we do not currently support latin squares of size greater than 10x10")
    else
      client.say(channel: data.channel, text: "Computing orthogonal squares of size #{match[:size]}x#{match[:size]}. Will post in \#latin_squares channel")
      container_name = "latin_squares#{Random.new_seed}"
      puts "==============computing square of size #{match[:size]}============="
      time1 = Time.new
      puts "Current Time : " + time1.inspect
      # puts "I was made on #{get_line_number}"
      command = "docker service create \
      --constraint node.role==worker \
      --limit-cpu 2.5 \
      --no-resolve-image \
      --restart-condition none \
      --name #{container_name} champain/latin_squares:latest \
      #{match[:size]} https://hooks.slack.com/services/#{ENV['MOLS_SLACK_API_KEY']}"
      system(command)
    end
  end
end

SlackRubyBot::Client.logger.level = Logger::WARN

Bot.run
