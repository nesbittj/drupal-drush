FROM drupal

RUN apt-get update && apt-get install -y wget mysql-client

RUN wget http://files.drush.org/drush.phar
RUN php drush.phar core-status
RUN chmod +x drush.phar
RUN mv drush.phar /usr/local/bin/drush
RUN drush init -y
