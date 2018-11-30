FROM ruby:2.5.1-alpine
RUN apk add --update --no-cache \
            build-base \
            tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

CMD ["bundle", "exec", "rails", "s", "-p", "3050"]
