# XLP System Auto Deploy

This project is designed to automatically deploy an XLP System to a server.

Just run setup.sh and it will be finished automatically.

## System supported:

- Ubuntu server 16.04

## Steps

1. Run setup_empty.sh to deploy a system with empty database.

2. Run setup_continue.sh to download and deploy data from http://xlp.mit.edu/

## Current functions

- Install necessary software, including Docker, pip, docker-compose, Apache2

- Initialize all containers, including MariaDB, Mediawiki, Matomo, ElasticSearch, WordPress, Kibana.
Phabricator will be added later.

- Automatically pulling data from server 47.104.10.43, and restart the containers.