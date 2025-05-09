FROM ruby:3.3

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    libyaml-dev \
    nodejs \
    yarn \
    git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /myapp

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install && \
    rm -rf ~/.bundle/ /usr/local/bundle/cache /usr/local/bundle/ruby/*/bundler/gems/*/.git

COPY . .

# entrypoint.shの追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
