#! /bin/bash
serverip='47.104.10.43'
rsync -vazu --progress --delete root@${serverip}::xlpdata /data/xlpsystem --password-file=/data/pw.passwd
chmod -R 777 /data/xlpsystem