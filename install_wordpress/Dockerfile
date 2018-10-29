FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl ca-certificates mysql-client php7.2-cli php7.2-mysql php7.2-gd php7.2-mbstring && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY install_wordpress.sh /install_wordpress.sh

CMD ["bash", "/install_wordpress.sh"]
