FROM test_ruby_arm

COPY  mols_bot.rb Gemfile /

RUN bundle install

CMD ["bundle exec ruby ./mols_bot.rb"]
