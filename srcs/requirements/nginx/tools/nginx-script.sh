#!/bin/bash

# Dossier pour stocker le certificat SSL
mkdir -p /etc/nginx/ssl

# Génération du certificat SSL auto-signé s'il n'existe pas encore
if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

# Lancer NGINX au premier plan (PID 1)
exec nginx -g "daemon off;"