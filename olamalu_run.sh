#!/bin/bash
# build drupal site with docker

#build docker image from github dockerfile
docker build -t olamalujonathan/drupal-drush https://github.com/nesbittj/drupal-drush.git

#mysql container
mysql_root_pwd='rootpwd'

mysql_container_id=$(docker run -d -e MYSQL_ROOT_PASSWORD=$mysql_root_pwd -e MYSQL_USER=drupal -e MYSQL_PASSWORD=drupal mysql:latest)
#echo 'mysql_container_id: '$mysql_container_id
mysql_container_name=$(docker ps -f id=$mysql_container_id --format "{{.Names}}")

#run container from image, link to db
drupal_container_id=$(docker run -d --link $mysql_container_id -P olamalujonathan/drupal-drush)
#echo 'drupal_container_id: '$drupal_container_id
drupal_container_port=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' $drupal_container_id)
#echo 'drupal_container_port: '$drupal_container_port
drupal_container_hostname=$(docker inspect --format='{{.Config.Hostname}}' $mysql_container_id)
#echo 'drupal_container_hostname: '$drupal_container_hostname
drupal_container_name=$(docker ps -f id=$drupal_container_id --format "{{.Names}}")

#exec drush site-install on site in container
#drush si --site-name=sitename --db-url=mysql://root:rootpwd@clever_booth/dbname --db-su=root --db-su-pw=rootpwd -y
mysql_db_url="mysql://root:$mysql_root_pwd@$mysql_container_name/$drupal_container_name"
echo 'mysql_db_url: '$mysql_db_url
#drush_si_cmd="docker exec $drupal_container_id drush si --site-name=$drupal_container_hostname --db-url=$mysql_db_url --db-su=root --db-su-pw=$mysql_root_pwd -y"
#drush_si_cmd="docker exec $drupal_container_id drush si --site-name=sitename --db-url=$mysql_db_url --db-su=root --db-su-pw=$mysql_root_pwd -y"
drush_si_cmd="drush si --site-name=$drupal_container_name --db-url=$mysql_db_url --db-su=root --db-su-pw=$mysql_root_pwd -y -v --debug"
#echo $drush_si_cmd > drush_si_cmd.sh
#eval $drush_si_cmd
#docker exec -ti $drupal_container_id drush si --site-name=sitename --db-url=$mysql_db_url --db-su='root' --db-su-pw="$mysql_root_pwd" -y -v
#docker exec -ti $drupal_container_id $drush_si_cmd
docker exec $drupal_container_id bash -c "echo $drush_si_cmd > olamalu_si.sh && chmod +x olamalu_si.sh"
docker exec $drupal_container_id /bin/bash ./olamalu_si.sh

#exec correct permissions on files dir
docker exec $drupal_container_id chown -R www-data:www-data sites/default/files
docker exec $drupal_container_id chmod -R 0700 sites/default/files
#docker exec $drupal_container_id drush cr

echo 'your new site: http://localhost:'$drupal_container_port