#!/bin/bash

set -euo pipefail

# Don't do anything if Wordpress is already installed and configured.
if [ -e "/pbj/wp-config.php" ]; then
	echo "Wordpress is installed!"
	while true; do
		sleep 60
	done
fi

# Wait for the user to clear out ~/Sites/pbj
until [ "$(ls -Ala /pbj | wc -l)" == 3 ]; do
	echo
	echo '**** Your ~/Sites/pbj directory is NOT empty! Unable to clone Candela from Pantheon.'
	echo
	sleep 10
done

echo
echo '**** Beginning Candela installation...'
echo

sleep 10

# Git is not provided by this container
apt-get update
apt-get install -y git

# Clone Candela from Pantheon
GIT_URL=`grep candela_git_url /root/.pantheon/candela_config.ini | cut -f2 -d=`
git clone "${GIT_URL}" /pbj

# We won't be using Git again
apt-get purge -y git

# Setup local Wordpress config - DB config
cd /pbj
cp wp-config-sample.php wp-config-local.php
sed -i 's/database_name_here/pbj/' /pbj/wp-config-local.php
sed -i 's/username_here/pbj/' /pbj/wp-config-local.php
sed -i 's/password_here/pbj/' /pbj/wp-config-local.php
sed -i 's/localhost/db/' /pbj/wp-config-local.php

# Setup local Wordpress config - authentication unique keys and salts
curl https://api.wordpress.org/secret-key/1.1/salt/ > /tmp/wp_auth.txt

config_line=`grep \'AUTH_KEY\' /tmp/wp_auth.txt`
sed -i "/'AUTH_KEY'/c\\""${config_line}" /pbj/wp-config-local.php

config_line=`grep \'SECURE_AUTH_KEY\' /tmp/wp_auth.txt`
sed -i "/'SECURE_AUTH_KEY'/c\\""${config_line}" /pbj/wp-config-local.php

config_line=`grep \'LOGGED_IN_KEY\' /tmp/wp_auth.txt`
sed -i "/'LOGGED_IN_KEY'/c\\""${config_line}" /pbj/wp-config-local.php

config_line=`grep \'NONCE_KEY\' /tmp/wp_auth.txt`
sed -i "/'NONCE_KEY'/c\\""${config_line}" /pbj/wp-config-local.php

config_line=`grep \'AUTH_SALT\' /tmp/wp_auth.txt`
sed -i "/'AUTH_SALT'/c\\""${config_line}" /pbj/wp-config-local.php

config_line=`grep \'SECURE_AUTH_SALT\' /tmp/wp_auth.txt`
sed -i "/'SECURE_AUTH_SALT'/c\\""${config_line}" /pbj/wp-config-local.php

config_line=`grep \'LOGGED_IN_SALT\' /tmp/wp_auth.txt`
sed -i "/'LOGGED_IN_SALT'/c\\""${config_line}" /pbj/wp-config-local.php

config_line=`grep \'NONCE_SALT\' /tmp/wp_auth.txt`
sed -i "/'NONCE_SALT'/c\\""${config_line}" /pbj/wp-config-local.php

rm /tmp/wp_auth.txt


# FIXME: Remove after testing
while true; do
	sleep 60
done
