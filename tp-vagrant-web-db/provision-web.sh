#!/bin/bash

set -e

echo "[INFO] Provision Web – installation Apache, PHP et phpMyAdmin"

# Mise à jour
apt update -y

# Installer Apache + PHP + extensions si non installés
if ! dpkg -l | grep -q apache2; then
    apt install -y apache2
fi

if ! dpkg -l | grep -q php-mysql; then
    apt install -y php php-cli php-mysql
fi

# Activer Apache au démarrage
systemctl enable apache2

# Installer phpMyAdmin (si non installé)
if ! dpkg -l | grep -q phpmyadmin; then
    export DEBIAN_FRONTEND=noninteractive
    apt install -y phpmyadmin
fi

# Créer le lien symbolique si nécessaire
if [ ! -L /var/www/html/phpmyadmin ]; then
    ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
fi

# Configurer phpMyAdmin pour DB distante
PHPMYADMIN_CFG="/etc/phpmyadmin/config.inc.php"

if ! grep -q "192.168.56.11" $PHPMYADMIN_CFG; then
cat <<EOF >> $PHPMYADMIN_CFG

\$cfg['Servers'][\$i]['host'] = '192.168.56.11';
\$cfg['Servers'][\$i]['connect_type'] = 'tcp';
EOF
fi

# Redémarrer Apache
systemctl restart apache2

echo "[INFO] Provision Web terminé."
