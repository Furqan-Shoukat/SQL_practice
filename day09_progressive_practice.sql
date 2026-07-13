-- Progressive practice: combining joins, aggregates, HAVING, CASE, subqueries
-- Level 1 complete (Q1-3), Level 2 in progress
-- Skills: aggregate across join chain, compare-group-to-overall (HAVING + scalar subquery),
--         CASE label on aggregate
-- Database: DVDrental (PostgreSQL)
-- Date: 2026-07-13 

--- Level 1 — Reactivation

--- 1. Finance wants every country and the total revenue collected from customers based there, sorted highest to lowest.

SELECT c3.country, SUM(p.amount) AS total_revenue  
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
INNER JOIN address a ON a.address_id = c.address_id 
INNER JOIN city c2 ON c2.city_id = a.city_id 
INNER JOIN country c3 ON c2.country_id = c3.country_id
GROUP BY c3.country_id 
ORDER BY total_revenue DESC;

--- 2. The catalog team needs each film rating with its average rental rate and its longest film, 
--- but only for ratings whose average rental rate sits above the store-wide average rental rate.

SELECT f.rating AS film_rating, AVG(f.rental_rate) AS average_rental_rate, MAX(f.length) AS longest_film_duration
FROM film f
GROUP BY f.rating
HAVING AVG(f.rental_rate) > (SELECT AVG(f.rental_rate) 
FROM film f);

--- 3. Management wants each store labeled "Large" if it holds more than 2,300 inventory items and "Standard" otherwise, 
--- shown alongside the actual count.

SELECT i.store_id, count(i.film_id) AS total_inventory, 
		CASE WHEN count(i.film_id) > 2300 THEN 'Large'
	 	ELSE 'Standard' END AS store_label
FROM inventory i
GROUP BY i.store_id; 
