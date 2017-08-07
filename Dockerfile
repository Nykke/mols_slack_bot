FROM nykke/ruby_raspbian

COPY  mols_bot.rb Gemfile /

RUN apt-get update \
&& apt-get install -y apt-transport-https build-essential

RUN echo "deb [arch=armhf] https://download.docker.com/linux/debian \
     jessie stable" | \
    tee /etc/apt/sources.list.d/docker.list

RUN apt-get key adv --keysever keyring.debian.org --recv-keys 7EA0A9C3F273FCD8

RUN apt-get update \
&& apt-get install -y docker-ce \
&& apt-get install -y --no-install-recommends

RUN bundle install

CMD ["bundle","exec","ruby","/mols_bot.rb"]
