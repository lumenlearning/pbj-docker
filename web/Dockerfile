FROM ubuntu:18.04

RUN apt-get update && \
	apt-get install -y tzdata && \
	apt-get install -y --no-install-recommends \
		apache2 ssl-cert libapache2-mod-php7.2 php7.2-mysql php-redis

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
