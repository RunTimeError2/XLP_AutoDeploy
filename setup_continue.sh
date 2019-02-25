#! /bin/bash

serverip='34.233.193.13'
typeset -l dirname
dirname=$(basename `pwd`)

echo 'Shutting down current containers...'
docker-compose down

echo 'Backing up configuration files...'
mkdir /data/conf_bak
cp /data/xlpsystem/mediawiki/LocalSettings.php /data/conf_bak/LocalSettings.php
cp /data/xlpsystem/matomo/config/config.ini.php /data/conf_bak/config.ini.php

echo 'Deleting empty database...'
rm -r /data/xlpsystem/mariadb

echo 'Copying necessary files...'
cp ./pw.passwd /data/pw.passwd
chmod 600 /data/pw.passwd
cp ./pw.password /data/pw.password
chmod 600 /data/pw.password
echo 'Fetching data via rsync...'
rsync -vazu --progress --delete root@${serverip}::xlpdata /data/xlpsystem/ --password-file=/data/pw.passwd
chmod -R 777 /data/xlpsystem

echo 'Restarting containers...'
docker-compose up -d
docker cp ./xlp.png ${dirname}_mediawiki_1:/var/www/html/resources/assets/xlp.png
