#! /bin/bash
dirname=$(basename `pwd`)
docker-compose up -d
docker cp ./xlp.png ${dirname}_mediawiki_1:/var/www/html/resources/assets/xlp.png