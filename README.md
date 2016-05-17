Olamalu Drupal Docker Deploy
=============

Work in progress

Intension
--------------
Single command to deploy a new drupal site and dev environment.  
This is done by building and runnin g two docker containers, one drupal and one mysql.


Usage
---------

```
$ ./olamalu_run.sh
```
or
```
$ cd php
$ php composer.phar install
$ php olamalu_run.php
```

Bugs / Missing Features
-------
0. drush si failes to connect to mysql database when executed from shell script
0. missing input parameters for sitename, dev directory on local machine etc
0. docker volume is not created for dev environment


Links
--------
Docker Remote API client libraries  
https://docs.docker.com/engine/reference/api/remote_api_client_libraries/  
Docker inspect  
https://docs.docker.com/engine/reference/commandline/inspect/  