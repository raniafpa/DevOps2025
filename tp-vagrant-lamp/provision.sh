#!/usr/bin/env bash

set -e

echo "[INFO] Provisioning LAMP server..."

# Update packages (rejouable)
sudo apt-get update -y

# Installer Apache2 si non installé
if ! dpkg -l | grep -q apache2; then
    echo "[INFO] Installing Apache2..."
    sudo apt-get install -y apache2
fi

# Installer PHP si non installé
if ! dpkg -l | grep -q php-cli; then
    echo "[INFO] Installing PHP..."
    sudo apt-get install -y php php-cli
fi

# Activer Apache au démarrage
sudo systemctl enable apache2

# Nettoyer le répertoire web (rejouable)
sudo rm -rf /var/www/html/*

# Créer dossier partagé côté host si absent
if [ ! -d /vagrant/shared ]; then
    mkdir /vagrant/shared
fi

# Créer une page index.html (rejouable)
if [ ! -f /vagrant/shared/index.html ]; then
    echo "<h1>Bienvenue sur le LAMP Server Vagrant</h1>" > /vagrant/shared/index.html
fi

# Message MOTD (rejouable)
echo "VM LAMP – Debian 13" | sudo tee /etc/motd

echo "[INFO] Provisioning terminé."
