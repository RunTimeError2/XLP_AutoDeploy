#! /bin/bash

typeset -l dirname
dirname=$(basename `pwd`)
test_email='1761345180@qq.com'

echo 'Email Configuration...'
docker exec -u root ${dirname}_phabricator_1 /srv/phabricator/phabricator/bin/config set phpmailer.smtp-host smtp.qq.com
docker exec -u root ${dirname}_phabricator_1 /srv/phabricator/phabricator/bin/config set phpmailer.smtp-port 465
docker exec -u root ${dirname}_phabricator_1 /srv/phabricator/phabricator/bin/config set phpmailer.smtp-protocol SSL
docker exec -u root ${dirname}_phabricator_1 /srv/phabricator/phabricator/bin/config set phpmailer.smtp-user 1548039150@qq.com
docker exec -u root ${dirname}_phabricator_1 /srv/phabricator/phabricator/bin/config set phpmailer.smtp-password zcxybjpporwbjcgf

echo 'Phabricator Configuration...'
docker exec -u root ${dirname}_phabricator_1 /srv/phabricator/phabricator/bin/config set metamta.default-address 1548039150@qq.com
docker exec -u root ${dirname}_phabricator_1 /srv/phabricator/phabricator/bin/config set metamta.mail-adapter PhabricatorMailImplementationPHPMailerAdapter

echo 'Done.'
