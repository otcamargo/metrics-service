FROM ruby:2.6.2 as Builder

ARG APP_PATH=/opt/app/
WORKDIR $APP_PATH

COPY . $APP_PATH

# Install gems
RUN gem install bundler --version 2.1.4
RUN bundle config --global frozen 1
RUN bundle config without development test
# Remove unneeded files (cached *.gem, *.o, *.c)
RUN rm -rf /usr/local/bundle/cache/*.gem
RUN find /usr/local/bundle/gems/ -name "*.c" -delete
RUN find /usr/local/bundle/gems/ -name "*.o" -delete

RUN bundle install

ENV RAILS_ENV production

EXPOSE 3000

CMD [ "bundle", "exec", "rails", "server", "-e", "production", "-b", "0.0.0.0" ]
