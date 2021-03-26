-- Practice Joins 

-- 1.
SELECT * FROM invoice 
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > 0.99;


-- 2.
SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total 
FROM invoice JOIN customer ON customer.customer_id = invoice.customer_id; 


-- 3.
SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name
FROM customer JOIN employee 
ON customer.support_rep_id = employee.employee_id;


-- 4.
SELECT album.title, artist.name 
FROM album JOIN artist
ON album.artist_id = artist.artist_id;


-- 5.
SELECT playlist_track.track_id FROM playlist_track
JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';


-- 6.
SELECT track.name FROM track
JOIN playlist_track ON playlist_track.track_id = track.track_id
WHERE playlist_track.playlist_id = 5;


-- 7.
SELECT track.name, playlist.name FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id;


-- 8.
SELECT track.name, album.title 
FROM track JOIN album ON track.album_id = album.album_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Alternative & Punk';


-- Black Diamond
SELECT track.name, genre.name, album.title, artist.name 
FROM track
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
JOIN genre ON track.genre_id = genre.genre_id
JOIN playlist_track ON track.track_id = playlist_track.track_id
JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';


-- Pactice Nested Queries

-- 1.
SELECT * FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);


-- 2.
SELECT * FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');


-- 3.
SELECT name FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5); 


-- 4.
SELECT * FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy');


-- 5.
SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE name ='Fireball');


-- 6.
SELECT * FROM track
WHERE album_id IN (
    SELECT album_id FROM album WHERE artist_id IN (
        SELECT artist_id FROM artist WHERE name ='Queen'));



-- Practice Updating Rows

-- 1.
UPDATE customer 
SET fax = null
WHERE fax IS NOT null;


-- 2.
UPDATE customer
SET company = 'Self'
WHERE company IS null;


-- 3.
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';


-- 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@tahoo.cl';


-- 5.
UPDATE track 
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal') AND composer IS null;

-- 6. 
DONE


-- Group By 

-- 1.
SELECT COUNT(*), genre.name
FROM track 
JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name;


-- 2.
SELECT COUNT(*), genre.name
FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Pop' OR genre.name = 'Rock'
GROUP BY genre.name;


-- 3.
SELECT artist.name, COUNT(*)
FROM artist
JOIN album ON artist.artist_id = album.artist_id
GROUP BY artist.name;



-- Use Distinct 


-- 1.
SELECT DISTINCT composer
FROM track;


-- 2.
SELECT DISTINCT billing_postal_code
FROM invoice;


-- 3.
SELECT DISTINCT company
FROM customer;



-- Delete Rows

-- 1.
DONE

-- 2. 
DELETE FROM practice_delete
WHERE type = 'bronze';


-- 3. 
DELETE FROM practice_delete 
WHERE type = 'silver';


-- 4. 
DELETE FROM practice_delete
WHERE value = 150;



-- eCommerce Simulation

CREATE TABLE user4 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE products2 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  price INTEGER
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  product_id INTEGER REFERENCES products2(id)
);

INSERT INTO user4 (name, email)
VALUES 
  ('Rich', 'rich@email.com'),
  ('Val', 'val@email.com'),
  ('Lilah', 'lilah@email.com');

INSERT INTO products2 (name, price)
VALUES  
  ('hat', 25),
  ('jacket', 90),
  ('shirt', 55);

INSERT INTO orders (product_id)
VALUES 
  (1), 
  (2), 
  (3);

SELECT * FROM orders 
WHERE id = 1;

SELECT * from orders;

SELECT SUM(price) FROM products2
JOIN orders ON products2.id = orders.product_id
WHERE orders.id = 1;

ALTER TABLE orders 
ADD COLUMN user_id INTEGER REFERENCES user4(id);

UPDATE orders
SET user_id = 1
WHERE id = 1;

UPDATE orders
SET user_id = 2
WHERE id = 2;

UPDATE orders
SET user_id = 3
WHERE id = 3;

SELECT * FROM orders
JOIN user4 ON orders.user_id = user4.id
WHERE user4.id = 1;

SELECT user4.name, COUNT(*)
FROM orders 
JOIN user4 ON user4.id = orders.user_id
GROUP BY user4.name;

-- Black Diamond
SELECT user4.name, COUNT(*), SUM(price)
FROM orders 
JOIN user4 ON user4.id = orders.user_id
JOIN products2 ON products2.id = orders.product_id 
GROUP BY user4.name;