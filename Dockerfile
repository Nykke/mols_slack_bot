FROM test_ruby_arm

COPY  mols_bot.rb Gemfile /

RUN bundle install

CMD ["SLACK_API_TOKEN=$MOLS_SLACK_API_KEY bundle exec ruby ./mols_bot.rb"]
