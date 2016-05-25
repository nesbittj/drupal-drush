<?php

/*
build drupal site with docker
*/

require_once __DIR__ . '/vendor/autoload.php';

use Docker\Docker;

function olamalu_si()
{
	$docker = new Docker();
	$containers = $docker->getContainerManager()->findAll();
	echo json_encode($containers);

		/*
	//build docker image from github dockerfile
	$output = shell_exec('docker build -t olamalujonathan/drupal-drush https://github.com/nesbittj/drupal-drush.git');

	#mysql container
	$mysql_root_pwd = 'rootpwd';
	$mysql_container_id = shell_exec("docker run -d -e MYSQL_ROOT_PASSWORD=$mysql_root_pwd -e MYSQL_USER=drupal -e MYSQL_PASSWORD=drupal mysql:latest");	
	$mysql_container_name = shell_exec("docker ps --format '{{.Names}}' -f id=$mysql_container_id");

	#run container from image, link to db
	$cmd = "docker run -P -d --link $mysql_container_id olamalujonathan/drupal-drush";
	echo $cmd;
	$drupal_container_id = shell_exec($cmd);
	echo $drupal_container_id;

	$drupal_container_port = shell_exec("docker inspect --format='{{(index (index .NetworkSettings.Ports \"80/tcp\") 0).HostPort}}' $drupal_container_id");
	$drupal_container_hostname = shell_exec("docker inspect --format='{{.Config.Hostname}}' $mysql_container_id");
	$drupal_container_name=shell_exec("docker ps -f id=$drupal_container_id --format '{{.Names}}'");

	#exec drush site-install on site in container
	$mysql_db_url = "mysql://root:$mysql_root_pwd@$mysql_container_name/$drupal_container_name";
	$drush_si_cmd = "drush si --site-name=$drupal_container_name --db-url=$mysql_db_url --db-su=root --db-su-pw=$mysql_root_pwd -y -v --debug";
	//docker exec $drupal_container_id bash -c "echo $drush_si_cmd > olamalu_si.sh && chmod +x olamalu_si.sh"
	//docker exec $drupal_container_id /bin/bash ./olamalu_si.sh
	$output = shell_exec("docker exec $drush_si_cmd");

	#exec correct permissions on files dir
	$output = shell_exec("docker exec $drupal_container_id chown -R www-data:www-data sites/default/files");
	$output = shell_exec("docker exec $drupal_container_id chmod -R 0700 sites/default/files");
	#docker exec $drupal_container_id drush cr

	echo "your new site: http://localhost:$drupal_container_port";
	*/
}

olamalu_si();

 ?>