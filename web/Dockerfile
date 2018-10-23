FROM ubuntu:18.04

RUN apt-get update && \
	apt-get install -y tzdata && \
	apt-get install -y --no-install-recommends \
		apache2 libapache2-mod-php7.2 php7.2-mysql php-redis
#		apache2 libapache2-mod-php7.0 php7.0-mysql php7.0-oauth php-redis && \
#   apt-get clean && \
#	  rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf


# Add PHP OAuth extension by temporarily installing packages to download and compile it
RUN apt-get install -y --no-install-recommends \
	apt-get install -y tzdata && \
	php7.2-dev php-pear make && \
	pecl install oauth-2.0.2 && \
	apt-get purge -y php7.2-dev php-pear make && \
	echo 'extension=oauth.so' >> /etc/php/7.2/apache2/php.ini && \
	apt-get clean && \
	rm -rf /var/ilb/apt/lists/*

COPY start-apache.sh /
RUN chmod 755 /start-apache.sh

EXPOSE 80

CMD "/start-apache.sh"
