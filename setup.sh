#! /bin/bash

serverip='47.104.10.43
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
	apt-get install apache2 -yet
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

# Synchronizing data file
echo 'Synchronizing data file from server ${serverip}'
service rsync start
rsync -vazu --progress --delete root@${serverip}::xlpdata /data/xlpsystem/ --password-file=/data/pw.passwd
echo 'Data successfully synchronized.'

echo 'Fetching data from server ${serverip}' #===============================================
cp ./pw.passwd /data/pw.passwd
chmod 600 /data/pw.passwd
rsync -vazu --progress --delete root@${serverip}::xlpdb /data/db_pak --password-file=/data/pw.passwd
echo 'Restoring data...'
docker exec -u root ${dirname}_mariadb_1 mysql -uroot -pW2qgpsLtQt -A < /data/db_pak/xlp.sql

echo 'Stopping containers...'
docker-compose down
echo 'Containers successfully initialized.'

# Starting rsync daemon
echo 'Starting rsync daemon...'
echo 'Copying file...'
cp ./pw.password /data/pw.password
cp ./rsyncd.conf /etc/rsyncd.conf
chmod 600 /data/pw.password
echo 'Starting service...'
rsync --daemon --config=/etc/rsyncd.conf
echo 'rsync daemon successfully launched.'

# Deploy all scripts

# Deploy landpage

# Restart containers
echo 'Restarting containers...'
docker-compose up -d
echo 'Containers successfully restarted.'

echo 'Deployment completed.'