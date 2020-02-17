FROM ruby:2.6.5

EXPOSE 8080

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install --without development test

COPY . .

CMD ["bundle", "exec", "unicorn -c unicorn.rb"]
