Olamalu Drupal Docker Deploy
=============

Work in progress

Intension
--------------
Single command to deploy a new drupal site and dev environment.
This is done by building and runnin g two docker containers, one drupal and one mysql


Usage
---------

```
$ ./olamalu_run.sh
```
or
```
$ php composer.phar install
$ php php/olamalu_run.php
```

Bugs
-------
drush si failes to connect to mysql database when executed from shell script


Links
--------
Docker Remote API client libraries
https://docs.docker.com/engine/reference/api/remote_api_client_libraries/
Docker inspect
https://docs.docker.com/engine/reference/commandline/inspect/