#!/bin/bash

set -e

echo "[INFO] Installation MariaDB..."
apt-get update -y
apt-get install -y mariadb-server

echo "[INFO] Configuration bind-address..."
sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

systemctl enable mariadb
systemctl restart mariadb

echo "[INFO] Import SQL..."
mariadb < /vagrant/db_sql/db_init.sql

echo "[INFO] Provisioning DB terminé."
