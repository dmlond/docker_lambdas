FROM docker_lambda
MAINTAINER Darin London <darin.london@duke.edu>

RUN apk --update add --virtual build_deps \
    build-base ruby ruby-irb ruby-io-console \
    ruby-json ruby-dev libc-dev linux-headers
RUN gem install -N sinatra docker-api

ADD app.rb /var/www/app/app.rb
WORKDIR /var/www/app
EXPOSE 3000
CMD ["ruby", "app.rb"]
