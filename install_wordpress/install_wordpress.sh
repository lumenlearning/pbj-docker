#!/bin/bash

set -euo pipefail

# Don't do anything if Wordpress is already installed and configured.
if [ -e "/pbj/wp-config-local.php" ]; then
	echo "Wordpress is installed!"
	while true; do
		sleep 60
	done
fi

echo
echo '**** Beginning Candela installation...'
echo

sleep 10

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


echo
echo '*** Candela is installed!'
echo

# FIXME: Remove after testing
while true; do
	sleep 60
done
