FROM       abevoelker/ruby
MAINTAINER WimW

# Add 'web' user which will run the application
RUN adduser web --home /home/web --shell /bin/bash --disabled-password --gecos ""

# Separate Gemfile ADD so that `bundle install` can be cached more effectively
ADD Gemfile      /var/www/
ADD Gemfile.lock /var/www/
RUN chown -R web:web /var/www &&\
  mkdir -p /var/bundle &&\
  chown -R web:web /var/bundle
RUN su -c "cd /var/www && bundle install --deployment --path /var/bundle" -s /bin/bash -l web

# Add application source
ADD . /var/www
RUN chown -R web:web /var/www

USER web

WORKDIR /var/www

CMD ["bundle", "exec", "foreman", "start"]
