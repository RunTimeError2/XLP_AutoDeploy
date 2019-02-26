#! /bin/bash

echo 'Shutting down containers...'
docker-compose down
echo 'Deleting data directory...'
docker-compose -f EStest.yml up -d
echo 'Awaiting container...'
sleep 30s
docker-compose -f EStest.yml down
chmod -R 777 /data/xlpsystem/elasticsearch
echo 'Restarting container, please check...'
docker-compose -f EStest.yml up

