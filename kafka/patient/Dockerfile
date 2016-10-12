FROM ruby:alpine
MAINTAINER Darin London <darin.london@duke.edu>

RUN gem install -N ruby-kafka

ADD patient.rb /usr/local/bin/patient.rb
RUN chmod +x /usr/local/bin/patient.rb

ENTRYPOINT /usr/local/bin/patient.rb
