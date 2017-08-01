FROM test_ruby_arm

COPY  mols_bot.rb Gemfile /

RUN apt-get update

RUN apt-get install build-essential

RUN bundle install

CMD ["bundle","exec","ruby","/mols_bot.rb"]
