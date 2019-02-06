USE sakila;
-- 1a
SELECT first_name, last_name FROM actor;
-- 1b
SELECT concat(first_name,", ",last_name) AS "Actor Name" FROM actor;
-- 2a
SELECT actor_id,first_name,last_name FROM actor WHERE first_name LIKE "Joe";
-- 2b
SELECT actor_id,first_name,last_name FROM actor WHERE last_name LIKE "%gen%";
-- 2c
SELECT actor_id,first_name,last_name 
FROM actor 
WHERE last_name LIKE "%LI%"
ORDER BY last_name,first_name;
-- 2d
SELECT country, country_id FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");
-- 3a
ALTER TABLE actor ADD COLUMN description BLOB;
-- 3b
ALTER TABLE actor DROP COLUMN description;
-- 4a 
SELECT last_name, COUNT(last_name) AS last_name_count FROM actor
GROUP BY last_name;
-- 4b
SELECT last_name, COUNT(last_name) AS last_name_count FROM actor 
GROUP BY last_name
HAVING last_name_count > 1;
-- 4c
SELECT last_name, first_name FROM actor WHERE first_name = "Harpo"; 
UPDATE actor 
SET first_name = "Harpo"
WHERE first_name = "Groucho" AND last_name = "Williams";
-- 4d 
UPDATE actor 
SET first_name = "Groucho"
WHERE first_name = "Harpo" AND last_name = "Williams";
-- 5a
SHOW CREATE TABLE address;
-- 6a
SELECT staff.first_name, staff.last_name, address.address 
  FROM address 
  INNER JOIN staff
  ON staff.address_id = address.address_id;
-- 6b
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS Total Amount
  FROM staff 
  INNER JOIN payment
  ON staff.staff_id = payment.staff_id;
-- 6c
SELECT film.title, COUNT(film_actor.actor_id) AS "number of actors"
  FROM film 
  INNER JOIN film_actor
  ON film.film_id = film_actor.film_id
  GROUP BY actor_id;
-- 6d
SELECT film.title, COUNT(inventory.inventory_id) AS "number of copies"
  FROM inventory 
  INNER JOIN film
  ON inventory.film_id = film.film_id
  WHERE film.title LIKE "Hunchback Impossible";
-- 6e
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS "Total Amount"
  FROM customer 
  JOIN payment
  ON customer.customer_id = payment.customer_id
  GROUP BY customer.customer_id
  ORDER BY customer.last_name;
-- 7a
SELECT title
  FROM film
  WHERE (title LIKE 'K%' OR title LIKE 'Q%') and language_id IN
  (
  SELECT language_id
  FROM language
  WHERE name = "english"
  );
-- 7b
SELECT first_name, last_name
  FROM actor
  WHERE actor_id IN
  (
  SELECT actor_id
  FROM film
  WHERE title = "Alone Trip"
  );
-- 7c
SELECT customer.first_name, customer.last_name, customer.email
  FROM customer 
  JOIN address
  ON customer.address_id = address.address_id
  JOIN city
  ON address.city_id = city.city_id
  JOIN country
  ON city.country_id = country.country_id
  WHERE country = 'Canada';
-- 7d
SELECT title
  FROM film
  WHERE film_id in
  (
  SELECT film_id
  FROM film_category
  WHERE category_id IN
  (
  SELECT category_id
  FROM category
  WHERE name = "family"
  )
  );
-- 7e
SELECT  film.title,COUNT(rental.rental_id) AS "Times Rented" FROM inventory
JOIN film
ON inventory.film_id = film.film_id
JOIN rental 
ON inventory.inventory_id = rental.inventory_id
GROUP BY inventory.film_id 
ORDER BY COUNT(rental.rental_id) DESC;
-- 7f
SELECT customer.store_id, SUM(payment.amount)
  FROM customer
  JOIN payment
  ON customer.customer_id = payment.customer_id
  GROUP BY customer.store_id
  ;
-- 7g
SELECT store.store_id, store.address_id, address.address, city.city,country.country
  FROM store
  JOIN address
  ON store.address_id = address.address_id
  JOIN city 
  ON address.city_id = city.city_id
  JOIN country
  ON city.country_id = country.country_id
  ;
-- 7h
SELECT category.name AS "Genre", SUM(payment.amount) AS "Total Revenue"
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.rental_id
JOIN payment 
ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5
;
-- 8a
CREATE VIEW Top_Five_Genres AS(
SELECT category.name AS "Genre", SUM(payment.amount) AS "Total Revenue"
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.rental_id
JOIN payment 
ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5);
-- 8b
SELECT * FROM Top_Five_Genres;
-- 8c
DROP VIEW Top_Five_Genres;