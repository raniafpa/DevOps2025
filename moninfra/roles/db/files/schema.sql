-- Création de la table users
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--- Insertion de données initiales si elles n'existent pas
INSERT INTO users (username, email)
SELECT 'alice', 'alice@example.com'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'alice');

INSERT INTO users (username, email)
SELECT 'bob', 'bob@example.com'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'bob');