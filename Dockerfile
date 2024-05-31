# 最新安定版の3.2.4がrbenvでインストールできなかったため、下記バージョンを指定
FROM ruby:3.2.3


RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
EXPOSE 3306

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
