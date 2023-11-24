FROM ruby:3.0.0
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
