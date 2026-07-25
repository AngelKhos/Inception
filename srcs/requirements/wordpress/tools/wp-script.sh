#!/bin/bash

# Attendre que MariaDB soit prêt sur le réseau
sleep 10

# Se placer dans le répertoire web
cd /var/www/html

# Si wp-config.php n'existe pas, installer WordPress
if [ ! -f wp-config.php ]; then

    # 1. Télécharger le cœur de WordPress
    wp core download --allow-root

    # 2. Créer le fichier wp-config.php connecté à MariaDB
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb:3306" \
        --allow-root

    # 3. Installer le site (titre, admin user, etc.)
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${SITE_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    # 4. Créer un second utilisateur (exigé par le sujet 42 : 1 admin + 1 user)
    wp user create \
        "${WP_USER}" "${WP_EMAIL}" \
        --user_pass="${WP_PASSWORD}" \
        --role=author \
        --allow-root

fi

# Lancer PHP-FPM au premier plan (PID 1)
exec php-fpm8.2 -F