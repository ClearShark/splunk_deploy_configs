#!/bin/bash

cd /tmp
sudo adduser splunk
sudo yum install wget -y

sudo wget -O splunk-8.1.2-545206cc9f70-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.2&product=splunk&filename=splunk-8.1.2-545206cc9f70-linux-2.6-x86_64.rpm&wget=true'
sudo rpm -i /tmp/splunk-8.1.2-545206cc9f70-linux-2.6-x86_64.rpm
sudo chown -R splunk:splunk /opt/splunk
sudo chmod -R 755 /opt/splunk
sudo -u splunk bash -c 'cat <<EOF > /opt/splunk/etc/system/local/user-seed.conf
[user_info]
USERNAME = admin
PASSWORD = clearshark123!

EOF'

sudo chmod 400 /opt/splunk/var/lib/splunk/kvstore/mongo/splunk.key
sudo /opt/splunk/bin/splunk enable boot-start -systemd-managed 1 -user splunk --accept-license --no-prompt --answer-yes
sudo systemctl daemon-reload
sudo systemctl enable Splunkd.service
sudo  /opt/splunk/bin/splunk start  --answer-yes --accept-license
