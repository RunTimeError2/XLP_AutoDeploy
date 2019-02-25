#! /bin/bash

serverip='34.233.193.13'
typeset -l dirname
dirname=$(basename `pwd`)

echo 'Shutting down current containers...'
docker-compose down
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
