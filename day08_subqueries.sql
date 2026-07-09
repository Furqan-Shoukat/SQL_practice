-- DataCamp: Joining Data in SQL practice
-- Skills: (semi/anti-joins, correlated, subquery in FROM)
-- Database: DVDrental (PostgreSQL)
-- Date: 2026-10-07

--- Practice set — DVDrental
--- Set 1 — Subquery in WHERE (semi-join: "in the list")
--- 1. List the titles of all films that have been rented at least once. (A film is rented if its inventory_id appears in rental — use WHERE film_id IN (subquery) through inventory.)
--- Hint: WHERE film_id IN (SELECT film_id FROM inventory WHERE inventory_id IN (SELECT inventory_id FROM rental)) — or simpler, films whose inventory appears in rentals.

SELECT f.title 
FROM film f 
WHERE f.film_id IN (SELECT i.film_id 
					FROM inventory i
					WHERE i.inventory_id IN (SELECT r.inventory_id FROM rental r));


---Set 2 — Anti-join ("NOT in the list")
--- 2. List films that have never been rented — this time using WHERE ... NOT IN (subquery) instead of the LEFT JOIN + IS NULL you did before. (Same answer, different technique — good to know both.)

SELECT DISTINCT f.title AS film_name
FROM film f
WHERE f.film_id NOT IN (SELECT i.film_id 
					FROM inventory i
					WHERE i.inventory_id IN (SELECT r.inventory_id FROM rental r));



---Set 3 — Subquery in SELECT
--- 3. For each film, show its title and — as a second column — the total number of films in the whole table (a single value repeated on every row). (Subquery in SELECT returning one number.)

SELECT f.title, (SELECT count(*) FROM film) AS total_number_of_films
FROM film f;
				

--- 4. Show each customer's first_name, last_name, and how many rentals they've made — using a subquery in SELECT that counts rentals for that customer. (Correlated subquery.)

SELECT c.first_name, c.last_name, 
								(SELECT count(*) 
								FROM rental r
								WHERE r.customer_id = c.customer_id)
								AS rental_count
FROM customer c
ORDER BY rental_count DESC;

--- Set 4 — Subquery in FROM
--- 5. Find the average number of rentals per customer. (Hint: first build a subquery that counts rentals per customer, then average those counts in the outer query — SELECT AVG(cnt) FROM (SELECT COUNT(*) AS cnt FROM rental GROUP BY customer_id) sub.)				


SELECT ROUND(AVG(cnt), 2) AS avg_number_of_rental
			FROM (SELECT count(*) AS cnt FROM rental r GROUP BY r.customer_id) AS sub; 