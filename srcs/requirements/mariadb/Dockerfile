FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb-script.sh /usr/local/bin/mariadb-script.sh

RUN chmod +x /usr/local/bin/mariadb-script.sh

ENTRYPOINT ["/usr/local/bin/mariadb-script.sh"]