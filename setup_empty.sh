#! /bin/bash

typeset -l dirname
dirname=$(basename `pwd`)

echo 'Start deploying XLP system...'

echo 'Updating source for apt-get...'
apt-get update

# Checking system environment
echo 'Checking system environment...'
which docker
if [ $? -ne 0 ]; then
	echo 'Docker not installed yet. Installing docker...'
	apt-get install docker.io -y
else
	echo 'Docker already installed.'
fi
which pip
if [ $? -ne 0 ]; then
	echo 'pip not installed yet. Installing pip...'
	apt-get install python-pip -y
else
	echo 'pip already installed.'
fi
which docker-compose
if [ $? -ne 0 ]; then
	echo 'Docker-compose not installed yet. Installing docker-compose...'
	pip install docker-compose
else
	echo 'Docker-compose already installed.'
fi
which apache2
if [ $? -ne 0 ]; then
	echo 'Apache2 not installed yet. Installing Apache2...'
	apt-get install apache2 -y
else
	echo 'Apache2 already installed.'
fi
echo 'Creating directories...'
mkdir /data
mkdir /data/xlpsystem
mkdir /data/db_pak
echo 'Finished checking system environment.'

# Initializing containers
echo 'Initializing containers, it will take a few minutes for the first time...'
docker-compose up -d
echo 'Waiting for 30s for containers to finish initializing...'
sleep 30s
echo 'Shutting down containers...'
docker-compose down

echo 'Fetching backing-up data from github...'
git clone https://github.com/benkoo/TensorCloud.git
echo 'Extractting backing-up data...'
unzip ./TensorCloud/xlpsystem/backups/xlpsystem_empty_20190206.zip
echo 'Copying data to /data ...'
rm -r /data/xlpsystem
cp -r ./xlpsystem/* /data/xlpsystem/
chmod -R 777 /data/xlpsystem

echo 'Launching containers...'
docker-compose up -d
echo 'Waiting for 10s for containers to finish initializing...'
sleep 10s

echo 'System with empty database has been deployed. Modify the configuration files and check if the system is operating normally.'
