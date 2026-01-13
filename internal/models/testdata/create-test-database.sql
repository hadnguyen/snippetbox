CREATE DATABASE IF NOT EXISTS test_snippetbox CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER 'test_web'@'%' IDENTIFIED BY 'pass';

GRANT ALL PRIVILEGES ON test_snippetbox.* TO 'test_web'@'%';
FLUSH PRIVILEGES;