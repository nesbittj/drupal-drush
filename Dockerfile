FROM drupal

RUN apt-get update && apt-get install -y wget

wget http://files.drush.org/drush.phar
php drush.phar core-status
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush
drush init -y
