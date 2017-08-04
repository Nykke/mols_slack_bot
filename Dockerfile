FROM resin/rpi-raspbian:jessie

COPY  mols_bot.rb Gemfile /

RUN apt-get update \
	&& apt-get install -y --no-install-recommends

RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.4"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN bundle install

CMD ["bundle","exec","ruby","/mols_bot.rb"]
