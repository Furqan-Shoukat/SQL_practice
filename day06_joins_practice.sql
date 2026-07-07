-- DataCamp: Joining Data in SQL practice
-- Skills: INNER JOIN, multi-table joins, LEFT JOIN + IS NULL, SELF JOIN
-- Database: DVDrental (PostgreSQL)
-- Date: 2026-07-06

--- Set 1 — INNER JOIN (matching rows in both tables)

--- 1. List each film's title alongside the language it's in. (film + language on language_id)

SELECT f.title AS movie_name, l.name AS language_name
FROM film f 
INNER JOIN LANGUAGE l
ON f.language_id = l.language_id;

--- 2. Show me each customer's first name, last name, and the city they live in. (customer → address → city — two joins)

SELECT c.first_name, c.last_name, ct.city  
FROM customer c
INNER JOIN address a 
ON c.address_id = a.address_id
INNER JOIN city AS ct
ON a.city_id = ct.city_id ; 

--- 3. For each payment, show the customer's full name and the amount paid — top 5 by amount. (customer + payment)


SELECT c.first_name || ' ' || c.last_name AS full_name, p.amount 
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
ORDER BY p.amount DESC
LIMIT 15;


---Set 2 — LEFT JOIN (the key new skill: finding rows with NO match)

--- 4. "Which films have never been rented? Show their titles." (film → inventory → rental, LEFT JOIN, then find where rental is NULL)

SELECT f.title AS film_name
FROM film f
LEFT JOIN inventory i
ON i.film_id = f.film_id
LEFT JOIN rental r
ON r.inventory_id = i.inventory_id
WHERE r.rental_id IS NULL;

--- 5. "List all films and how many times each was rented — including films rented zero times." (LEFT JOIN so unrented films still show, with a count of 0)

SELECT f.title AS film_name, count(r.rental_id) AS rented_count
FROM film f
LEFT JOIN inventory i
ON i.film_id = f.film_id
LEFT JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.title;

--- Set 3 — SELF JOIN (joining a table to itself)

--- 6. "Find pairs of customers who live in the same city. Show both customers' names and the city." (customer self-joined via address/city)

SELECT c1.first_name || ' ' || c1.last_name AS customer1,
       c2.first_name || ' ' || c2.last_name AS customer2,
       ct1.city 
FROM customer c1 
INNER JOIN address a1 ON c1.address_id = a1.address_id
INNER JOIN city ct1 ON ct1.city_id = a1.city_id
INNER JOIN customer c2 ON c2.customer_id > c1.customer_id
INNER JOIN address a2 ON c2.address_id = a2.address_id
INNER JOIN city ct2 ON ct2.city_id = a2.city_id
WHERE ct1.city_id = ct2.city_id;
