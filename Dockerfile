FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR /usr/src/app
COPY . .
RUN bundle install