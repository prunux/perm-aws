#!/bin/bash
apt update
apt install --no-install-recommends -y awscli jq
aws configure set aws_access_key_id AKXXXXXXXXXXXXXXXXXX
aws configure set aws_secret_access_key oozi0oop5chaifie7ieyu4oleezeequoo1Igho4E
aws configure set default.region eu-west-1
wget https://gitlab.com/prunux/perm-aws/raw/master/dynamic-ip.sh -O /usr/local/bin/dynamic-ip.sh
chmod a+rx /usr/local/bin/dynamic-ip.sh
perl -pi -e 's/##ZONEID##/BA9EEQUO8AAPH/' /usr/local/bin/dynamic-ip.sh
perl -pi -e 's/##YOURDOMAINTOUPDATE##/mysubdomain.mydomain.mytld/' /usr/local/bin/dynamic-ip.sh
/usr/local/bin/dynamic-ip.sh >> /var/tmp/dynamic-ip.log
echo '*/20 * * * * /usr/local/bin/dynamic-ip.sh >> /var/tmp/dynamic-ip.log 2>&1' >> /tmp/cronjob
echo '@reboot sleep 60 && /usr/local/bin/dynamic-ip.sh >> /var/tmp/dynamic-ip.log 2>&1' >> /tmp/cronjob
crontab /tmp/cronjob
perl -pi -e 's/##DBNAME##/perm/' /home/perm/public_html/db_config.yaml
perl -pi -e 's/##DBHOST##/perm.cluster-replaceme.eu-west-1.rds.amazonaws.com/' /home/perm/public_html/db_config.yaml
perl -pi -e 's/##DBPORT##/5432/' /home/perm/public_html/db_config.yaml
perl -pi -e 's/mydomainmytld/MYDOMAIN.MYTLD/g' /etc/apache2/sites-available/mysubdomain.mydomain.mytld.conf
perl -pi -e 's/mysubdomain/MYSUBDOMAIN/g' /etc/apache2/sites-available/mysubdomain.mydomain.mytld.conf
perl -pi -e 's/mydomain/MYDOMAIN/g' /etc/apache2/sites-available/mysubdomain.mydomain.mytld.conf
perl -pi -e 's/mytld/MYTLD/g' /etc/apache2/sites-available/mysubdomain.mydomain.mytld.conf
perl -pi -e "s/^VirtualHost[\s]/<VirtualHost /g" /etc/apache2/sites-available/mysubdomain.mydomain.mytld.conf
mv /etc/apache2/sites-available/mysubdomain.mydomain.mytld.conf /etc/apache2/sites-available/MYSUBDOMAIN.MYDOMAIN.MYTLD.conf
a2ensite MYSUBDOMAIN.MYDOMAIN.MYTLD.conf
systemctl reload apache2
certbot --apache -d MYSUBDOMAIN.MYDOMAIN.MYTLD -m admin@MYDOMAIN.MYTLD --agree-tos -n
systemctl reload apache2