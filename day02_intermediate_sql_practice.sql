---------------------------------------------------------------------------------------

--- Day 02  - SQL

--- DataCamp: Intermediate SQL practice
--- Chapters: Selecting Data + Filtering Records
--- Database: DVDrental (PostgreSQL)
--- Date: 2026-06-30

--- Set 1 — Selecting & basic filtering

--- How many films are in the film table?

SELECT count(*)
FROM film;

--- List all the distinct rating values that appear in film.

SELECT DISTINCT rating
FROM film;

---How many films have a rental_rate of exactly 0.99?

SELECT count(f.film_id) AS count_of_rental_rate
FROM film f
WHERE f.rental_rate = 0.99;

---How many films have a replacement_cost greater than 25?
SELECT count(f.film_id) AS cost_count
FROM film f
WHERE f.replacement_cost > 25;


--- Set 2 — AND / OR / BETWEEN

--- 5. How many films have length between 60 and 90 minutes (inclusive)? Use BETWEEN.

SELECT count(*) AS film_count
FROM film f
WHERE f.length BETWEEN 60 AND 90;


--- 6. How many films are rated 'PG' AND have a rental_rate below 3?

SELECT count(*) AS film_count
FROM film f 
WHERE f.rating IN ('PG')
AND f.rental_rate < 3; 

--- 7. List the titles of films that are rated 'G' OR 'PG-13' and have a length over 180 minutes.

SELECT title
FROM film f 
WHERE f.rating IN ('G', 'PG-13')
AND f.length > 180; 

--- 8. How many films have a rental_duration between 3 and 5 AND a rental_rate of 4.99?

SELECT count(*) AS film_count
FROM film f
WHERE (f.rental_duration BETWEEN 3 AND 5)
	AND f.rental_rate = 4.99;


--- Set 3 — LIKE / NOT LIKE / IN

--- 9. How many film titles start with the letter 'A'? (Use LIKE 'A%'.)

SELECT count(f.title) AS film_count_starting_with_A
FROM film f 
WHERE f.title LIKE ('A%');

--- 10. How many film titles contain the word 'LOVE' anywhere?

SELECT count(f.title) AS film_count_containing_Love
FROM film f 
WHERE f.title LIKE ('%LOVE%');

--- 11. List titles that do NOT start with a vowel (use NOT LIKE — hint: you'll need to exclude A, E, I, O, U starts; think about how to combine).

SELECT f.title AS witout_vowel
FROM film f
WHERE f.title NOT LIKE ('A%')
	AND (f.title NOT LIKE ('E%')
	AND f.title NOT LIKE ('I%')
	AND f.title NOT LIKE ('O%')
	AND f.title NOT LIKE ('U%'));

--- 12. How many films have a rating IN ('G', 'PG')? (Compare your answer to doing it with OR — same result.)

SELECT count(*) AS film_count
FROM film f 
WHERE f.rating IN ('G', 'PG');


--- Set 4 — NULL handling

--- 13. How many rows in address have a NULL address2? (Use IS NULL.)

SELECT count(*) AS count_empty_address
FROM address a 
WHERE a.address2 IS NULL;


--- 14. How many customers have a non-NULL email? (Use IS NOT NULL.)

SELECT count(*) AS customer_count
FROM customer c 
WHERE c.email IS NOT NULL; 
