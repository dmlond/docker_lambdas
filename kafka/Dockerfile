# Unfortunately, there is a bug in the ruby installed by apk
# in base alpine that is not in ruby:alpine
# so I have to replicate installation of docker in ruby:alpine
# instead of starting from docker_lambda
#FROM docker_lambda
FROM ruby:alpine
MAINTAINER Darin London <darin.london@duke.edu>

RUN apk update && apk add docker
RUN gem install -N ruby-kafka docker-api

ADD kafka_lambda.rb /usr/local/bin/kafka_lambda.rb
RUN chmod +x /usr/local/bin/kafka_lambda.rb

ENTRYPOINT /usr/local/bin/kafka_lambda.rb
