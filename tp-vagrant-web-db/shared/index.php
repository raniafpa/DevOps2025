<?php
$conn = new mysqli("192.168.56.11", "tp_user", "tp_password", "tp_db");

if ($conn->connect_error) {
    die("❌ Connexion échouée : " . $conn->connect_error);
}

echo "✅ Connexion DB réussie !<br>";
echo "Base de données : tp_db<br>";
echo "<br><a href='phpmyadmin'>➡️ Accéder à phpMyAdmin</a>";
?>
