--- DAY 03

-- DataCamp: Intermediate SQL practice
-- Chapter 3: Aggregate Functions (AVG, MIN, MAX, SUM, ROUND, arithmetic)
-- Database: DVDrental (PostgreSQL)
-- Date: 2026-07-01

--- 1. What is the average rental_rate across all films? (basic AVG)

SELECT round(avg(f.rental_rate), 2) AS average_rental_rate
FROM film f;

--- 2. What are the shortest and longest film length values, in one query? (MIN + MAX together)

SELECT min(f.length) AS min_length_film, max(f.length) AS max_length_film
FROM film f;

--- 3. What is the average rental_rate for films rated 'PG' only? (aggregate + WHERE)

SELECT round(avg(f.rental_rate), 2) AS average_rental_rate
FROM film f
WHERE f.rating IN ('PG');

--- 4. What is the average rental_rate across all films, rounded to 2 decimal places? (ROUND, positive parameter)

SELECT round(avg(f.rental_rate), 2)  AS average_rental_rate
FROM film f;


--- 5. Round the total replacement_cost of all films to the nearest 100. (ROUND with a negative parameter — ROUND(value, -2))

SELECT round(sum (f.replacement_cost), -2)  AS replacement_cost
FROM film f;

--- 6. For the first 10 films, show title and a calculated column net_value = replacement_cost - (rental_rate * 10). 
--- (arithmetic inside SELECT)

SELECT f.title, f.replacement_cost - (f.rental_rate * 10) AS net_value
FROM film f
LIMIT 10;


--- 7. In one query, show the average, min, and max rental_rate with clear aliases (avg_rate, min_rate, max_rate), all rounded to 2 decimals. (combining aggregates + aliasing)

SELECT round(min(f.rental_rate), 2)  AS minimum_rental_rate, 
round(max(f.rental_rate), 2)  AS maximum_rental_rate, 
round(avg(f.rental_rate), 2)  AS average_rental_rate
FROM film f;