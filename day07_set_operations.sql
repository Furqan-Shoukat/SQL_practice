-- DataCamp: Joining Data in SQL practice
-- Skills: UNION, UNION ALL, INTERSECT, EXCEPT
-- Database: DVDrental (PostgreSQL)
-- Date: 2026-09-06

--- Set 1 — UNION vs UNION ALL

--- 1. Get a single combined list of all first_name values from both customer and actor, with duplicates removed. (UNION)

SELECT c.first_name
FROM customer c 
UNION
SELECT a.first_name
FROM actor a;

--- 2. Now do the same but keep duplicates. (UNION ALL) — then note how the row count differs from #1.

SELECT c.first_name
FROM customer c 
UNION ALL
SELECT a.first_name
FROM actor a;

--- Set 2 — INTERSECT
--- 3. Which first_name values appear in both the customer table and the actor table? (INTERSECT — names shared by a customer and an actor)

SELECT c.first_name
FROM customer c 
INTERSECT
SELECT a.first_name
FROM actor a;

--- Set 3 — EXCEPT

--- 4. Which first_name values appear in customer but NOT in actor? (EXCEPT)

SELECT c.first_name
FROM customer c 
EXCEPT
SELECT a.first_name
FROM actor a;

--- Set 4 — combining with what you know
--- 5. Get a combined list of all city names from the city table AND all district names from the address table, into one column called location, duplicates removed.
SELECT c.city AS location
FROM city c 
UNION
SELECT a.district AS location
FROM address a;