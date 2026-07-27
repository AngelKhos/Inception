FROM debian:bookworm

# Installation de NGINX et OpenSSL
RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Copie de la configuration NGINX
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Copie du script d'entrée
COPY tools/nginx-script.sh /usr/local/bin/nginx-script.sh
RUN chmod +x /usr/local/bin/nginx-script.sh

ENTRYPOINT ["/usr/local/bin/nginx-script.sh"]