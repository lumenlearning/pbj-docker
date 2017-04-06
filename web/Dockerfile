FROM ubuntu:16.04

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		apache2 libapache2-mod-php7.0 php7.0-mysql
#		apache2 libapache2-mod-php7.0 php7.0-mysql php7.0-oauth && \
#   apt-get clean && \
#	  rm -rf /var/lib/apt/lists/*

# Add PHP OAuth extension by temporarily installing packages to download and compile it
RUN apt-get install -y --no-install-recommends \
	php7.0-dev php-pear make && \
	pecl install oauth-2.0.2 && \
	apt-get purge -y php7.0-dev php-pear make && \
	echo 'extension=oauth.so' >> /etc/php/7.0/apache2/php.ini && \
	apt-get clean && \
	rm -rf /var/ilb/apt/lists/*

COPY start-apache.sh /
RUN chmod 755 /start-apache.sh

EXPOSE 80

CMD "/start-apache.sh"
