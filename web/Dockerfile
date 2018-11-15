FROM ubuntu:18.04

RUN apt-get update && \
	apt-get install -y tzdata && \
	apt-get install -y --no-install-recommends \
		apache2 ssl-cert php-xdebug libapache2-mod-php7.2 php7.2-mysql php7.2-gd php7.2-mbstring php-redis

# PHP xdebug config 
# For VS Code related debug setup see https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug
RUN echo '[xdebug]' >> /etc/php/7.2/apache2/php.ini
RUN echo 'zend_extension = /usr/lib/php/20170718/xdebug.so' >> /etc/php/7.2/apache2/php.ini
RUN echo 'xdebug.remote_enable=1' >> /etc/php/7.2/apache2/php.ini
RUN echo 'xdebug.remote_autostart=1' >> /etc/php/7.2/apache2/php.ini
RUN echo 'xdebug.remote_port=9001' >> /etc/php/7.2/apache2/php.ini
RUN echo 'xdebug.remote_connect_back=0' >> /etc/php/7.2/apache2/php.ini
RUN echo 'xdebug.remote_host=docker.for.mac.localhost' >> /etc/php/7.2/apache2/php.ini
RUN echo 'xdebug.remote_log=/tmp/xdebug_log/xdebug.log' >> /etc/php/7.2/apache2/php.ini


# enable Apache modrewrite and SSL
RUN a2enmod rewrite && \
	a2enmod ssl && \
	a2ensite default-ssl

# Update apache conf to allow subdirectories
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf


# Add PHP OAuth extension by temporarily installing packages to download and compile it
RUN apt-get update && \
	apt-get install -y tzdata && \
	apt-get install -y --no-install-recommends \
	php7.2-dev php-pear make && \
	pecl install oauth-2.0.2 && \
	apt-get purge -y php7.2-dev php-pear make && \
	echo 'extension=oauth.so' >> /etc/php/7.2/apache2/php.ini && \
	apt-get clean && \
	rm -rf /var/ilb/apt/lists/*

COPY start-apache.sh /
RUN chmod 755 /start-apache.sh

EXPOSE 80 443

CMD "/start-apache.sh"
