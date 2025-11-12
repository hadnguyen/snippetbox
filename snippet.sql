-- Create a `snippets` table. 
CREATE TABLE snippets ( 
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(100) NOT NULL, 
    content TEXT, 
    created DATETIME NOT NULL, 
    expires DATETIME NOT NULL
 ); 

 -- Add an index on the created column. 
CREATE INDEX idx_snippets_created ON snippets(created);

-- Create a `sessions` table.
CREATE TABLE sessions ( 
token CHAR(43) PRIMARY KEY, 
data BLOB NOT NULL, 
expiry TIMESTAMP(6) NOT NULL
 ); 

-- Add an index on the expiry column.
CREATE INDEX sessions_expiry_idx ON sessions (expiry);

-- Add some dummy records
INSERT INTO snippetbox.snippets (title,content,created,expires) 
VALUES
('An old silent pond','An old silent pond...\nA frog jumps into the pond,\nsplash!','2025-10-08 10:50:54','2026-10-08 10:50:54'),
('Over the wintry forest','Over the wintry\nforest, winds howl in rage\nwith no leaves','2025-10-08 10:51:05','2026-10-08 10:51:05'),
('First autumn morning','First autumn morning\nthe mirror I stare into\nshows my father','2025-10-08 10:51:08','2025-10-15 10:51:08'),
('O snail','O snail\nClimb Mount Fuji,\nBut slowly, slowly!','2025-10-09 09:41:58','2025-10-16 09:41:58');

-- Create a `users` table.
CREATE TABLE users ( 
id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(255) NOT NULL, 
email VARCHAR(255) NOT NULL, 
hashed_password CHAR(60) NOT NULL, 
created DATETIME NOT NULL
 ); 

-- Add a unique constraint on the email column.
ALTER TABLE users ADD CONSTRAINT users_uc_email UNIQUE (email);