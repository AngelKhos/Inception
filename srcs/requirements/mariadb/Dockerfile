FROM debian:bookworm

# Installation de MariaDB et nettoyage du cache APT
RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Copie de la configuration et du script
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb-script.sh /usr/local/bin/mariadb-script.sh

# Donner les droits d'exécution au script
RUN chmod +x /usr/local/bin/mariadb-script.sh

# Lancement du script au démarrage du conteneur
ENTRYPOINT ["/usr/local/bin/mariadb-script.sh"]