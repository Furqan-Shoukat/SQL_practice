--- DAY 04

-- DataCamp: Intermediate SQL practice
-- Business questions
-- Database: DVDrental (PostgreSQL)
-- Date: 2026-07-03

--- Set 1 — ORDER BY (sorting)

--- 1. List the 5 films with the longest length — show title and length, longest first.

SELECT f.title, f.length
FROM film f
ORDER BY f.length DESC 
LIMIT 5;

--- 2. List all distinct rating values, sorted alphabetically.

SELECT DISTINCT f.rating 
FROM film f 
ORDER BY f.rating ASC;

--- 3. List the 10 cheapest films by rental_rate, then by title alphabetically as a tiebreaker. (Sorting by two fields.)

SELECT f.title, f.rental_rate 
FROM film f 
ORDER BY f.rental_rate, f.title
LIMIT 10;

--- Set 2 — GROUP BY (grouping + aggregating)

--- 4. How many films are there for each rating? Show rating and the count. (GROUP BY single field)

SELECT f.rating, count(*) AS film_count_for_each_rating
FROM film f
GROUP BY f.rating;

--- 5. What is the average rental_rate for each rating, rounded to 2 decimals? Sort highest average first.

SELECT f.rating, ROUND(AVG(f.rental_rate), 2) AS average_rental_for_each_rating
FROM film f 
GROUP BY f.rating
ORDER BY average_rental_for_each_rating DESC;

--- 6. For each combination of rating and rental_duration, count the films. (GROUP BY multiple fields)

SELECT f.rating, f.rental_duration, count(*) AS film_count  
FROM film f 
GROUP BY f.rating, f.rental_duration;


--- Set 3 — HAVING (filtering groups)

--- 7. Which ratings have more than 200 films? Show rating and the count. (GROUP BY + HAVING)

SELECT f.rating, count(*) AS rating_having_more_than_200_films
FROM film f 
GROUP BY f.rating 
HAVING count(*) > 200;

--- 8. Which ratings have an average rental_rate above 3? Show rating and the rounded average. (HAVING on an aggregate)

SELECT f.rating, round(avg(f.rental_rate), 2) AS average_rental_rate
FROM film f 
GROUP BY f.rating 
HAVING round(avg(f.rental_rate), 2) > 3;

--- Set 4 — All together (the assessment-style question)

--- 9. For each rating, show the count of films and the average length, 
--- but only for ratings where the average length is over 115 minutes, sorted by average length descending. 


SELECT f.rating, count(*) AS count_of_film, round(avg(f.length), 2) AS average_length
FROM film f 
GROUP BY f.rating 
HAVING avg(f.length) > 115
ORDER BY average_length DESC;


-------------


--- Day 05

--- 1. "What's the average price we charge to rent a film, rounded to 2 decimals?"
---(covers: AVG + ROUND, single table)

SELECT ROUND(avg(f.rental_rate), 2) AS average_price
FROM film f;

---2. "Give me our 5 longest movies — titles and runtimes, longest first."
---(covers: ORDER BY DESC + LIMIT)


SELECT f.title AS movie_name, f.length AS runtime
FROM film f 
ORDER BY f.length DESC
LIMIT 5;


---3. "Break down how many films we have in each rating category, and only show the categories with more than 200 titles. Sort biggest first."
---(covers: GROUP BY + COUNT + HAVING + ORDER BY — the full combo)

SELECT f.rating AS rating_category, count(*) AS rating_count
FROM film f
GROUP BY f.rating 
HAVING count(*) > 200
ORDER BY rating_count DESC; 