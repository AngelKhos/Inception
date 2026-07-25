FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y \
    php8.2 \
    php-fpm \
    php-mysql \
    mariadb-client \
    curl \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Télécharger wp-cli (l'outil de gestion WordPress en CLI)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copier la configuration custom PHP-FPM
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Créer le répertoire de destination des fichiers web
RUN mkdir -p /var/www/html /run/php && \
    chown -R www-data:www-data /var/www/html /run/php

COPY tools/wp-script.sh /usr/local/bin/wp-script.sh
RUN chmod +x /usr/local/bin/wp-script.sh

ENTRYPOINT ["/usr/local/bin/wp-script.sh"]