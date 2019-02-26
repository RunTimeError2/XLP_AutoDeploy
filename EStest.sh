#! /bin/bash

typeset -l dirname
dirname=$(basename `pwd`)

echo 'Shutting down containers...'
docker-compose down
echo 'Deleting directory...'
rm -r /data/elasticsearch

echo 'Starting container of ElasticSearch...'
docker-compose -f EStest.yml up -d
echo 'Awaiting container...'
sleep 20s
echo 'Shutting down...'
docker-compose -f EStest.yml down

sleep 5s
echo 'Restarting, please check...'
docker-compose -f EStest.yml up
