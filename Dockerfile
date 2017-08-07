FROM nykke/ruby_raspbian

COPY  mols_bot.rb Gemfile /

RUN apt-get update \
	&& apt-get install -y --no-install-recommends

RUN bundle install

CMD ["bundle","exec","ruby","/mols_bot.rb"]
