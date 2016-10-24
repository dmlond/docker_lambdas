FROM docker_lambda
MAINTAINER Darin London <darin.london@duke.edu>

RUN apk --update add --virtual build_deps \
    build-base ruby ruby-irb ruby-io-console \
    ruby-json ruby-dev libc-dev openssl openssl-dev \
    linux-headers redis
RUN gem install -N bundler docker-api

WORKDIR /var/www/app
ADD Gemfile /var/www/app/Gemfile
RUN ["bundle", "install", "--without", "development", "test", "--clean"]
EXPOSE 8080
CMD ["lita"]
