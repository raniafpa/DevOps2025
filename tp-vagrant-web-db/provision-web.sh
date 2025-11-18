#!/bin/bash

set -e

echo "[INFO] Installation Apache + PHP..."
apt-get update -y
apt-get install -y apache2 php php-mysql

systemctl enable apache2
systemctl restart apache2

echo "[INFO] Création fichier index.php..."
cat <<EOF > /vagrant/shared/index.php
<?php
\$conn = new mysqli("192.168.56.11", "tp_user", "tp_password", "tp_db");

if (\$conn->connect_error) {
    die("❌ Connexion échouée : " . \$conn->connect_error);
}

echo "✅ Connexion DB réussie !<br>";
echo "Base de données : tp_db<br>";
?>
EOF

echo "[INFO] Provisioning WEB terminé."
