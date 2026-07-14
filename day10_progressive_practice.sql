-- Progressive practice: combining joins, aggregates, HAVING, CASE, subqueries
-- Level 2, 3 complete, Level 4 in progress
-- Skills: aggregate across join chain, compare-group-to-overall (HAVING + scalar subquery),
--         CASE label on aggregate
-- Database: DVDrental (PostgreSQL)
-- Date: 2026-07-14 

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

------------------------


--- Level 2 — Conditional summaries

-- 1. Produce a single-row summary showing how many payments fall under $2, how many land between $2 and $5, and how many exceed $5.

SELECT
		COUNT(CASE WHEN p.amount < 2 THEN 1 END) AS payments_under_2_dollar,
		COUNT(CASE WHEN p.amount BETWEEN 2 AND 5 THEN 1 END) AS payments_between_2_and_5_dollar,
		COUNT(CASE WHEN p.amount > 5 THEN 1 END) AS payments_exceed_5_dollar
FROM payment p;

-- 2. For each customer, show their name and a loyalty tier: "Gold" if lifetime spend is over $150, "Silver" if over $100, otherwise "Bronze."

SELECT c.first_name, c.last_name,
		CASE WHEN SUM(p.amount) > 150 THEN 'Gold'
			 WHEN SUM(p.amount) > 100 THEN 'Silver'
			 ELSE 'Bronze' END AS loyalty_tier
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- 3. For each category, report the share (as a percentage) of its films rated R or NC-17 out of all films in that category.

SELECT c.name AS category, 
		ROUND(((count(CASE WHEN f.rating IN ('R', 'NC-17') THEN 1 END)* 100.00) / count(*)), 2) AS percentage
FROM film f 
INNER JOIN film_category fc ON f.film_id = fc.film_id 
INNER JOIN category c ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name;


--- Level 3 — Nested reasoning

--- 1. List every film whose rental rate is higher than the average rental rate of all films sharing its rating.

SELECT f1.title
FROM film f1
WHERE f1.rental_rate > (SELECT avg(f2.rental_rate) FROM film f2 WHERE f2.rating = f1.rating)

--- 2. Show the five customers with the highest lifetime spend, and beside each, the average lifetime spend across 
--- all customers, so every row can be read against the benchmark.

SELECT c.first_name || ' ' || c.last_name AS customer_name, 
		SUM(p.amount) AS amount_spent, 
		(
		 SELECT AVG(spend_avg) AS lifetime_average_of_all_customers 
		 FROM (
		 		SELECT sum(p2.amount) AS spend_avg 
		 		FROM payment p2 GROUP BY p2.customer_id
			   ) AS customers_total
		) 
FROM customer c 
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY amount_spent DESC
LIMIT 5;


--- 3. Identify all actors who have never appeared in a Horror film.

SELECT a.first_name || ' ' || a.last_name AS actor_name
FROM actor a
WHERE actor_id NOT IN (SELECT fa.actor_id
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON c.category_id = fc.category_id
INNER JOIN film_actor fa ON fa.film_id = f.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
WHERE c.name = 'Horror');
