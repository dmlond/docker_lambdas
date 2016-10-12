FROM ruby:alpine
MAINTAINER Darin London <darin.london@duke.edu>

RUN gem install -N rubylabs

ADD dockter.rb /usr/local/bin/dockter.rb
RUN chmod +x /usr/local/bin/dockter.rb

ENTRYPOINT /usr/local/bin/dockter.rb
