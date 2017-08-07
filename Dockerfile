FROM nykke/ruby_raspbian

COPY  mols_bot.rb Gemfile /

RUN echo deb [arch=armhf] http://download.docker.com/linux/debian \
     jessie stable | \
    tee /etc/apt/sources.list.d/docker.list

RUN apt-get update \
&& apt-get install -y build-essential docker-ce \
&& apt-get install -y --no-install-recommends

RUN bundle install

CMD ["bundle","exec","ruby","/mols_bot.rb"]
