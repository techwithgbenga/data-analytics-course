-- =============================================================================
-- Beginner: LIMIT and Aliasing
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

USE parks_and_recreation;

-- ---------------------------------------------------------------------------
-- LIMIT
-- ---------------------------------------------------------------------------

-- LIMIT restricts how many rows are returned.
SELECT *
FROM employee_demographics
LIMIT 3;

-- Combine it with ORDER BY to control which 3 rows you get
SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3;

-- LIMIT takes an optional second parameter: LIMIT <offset>, <row_count>
-- This says "skip the first 3 rows, then return the next 2"
SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3, 2;

-- Handy use case: find the 3rd oldest employee
SELECT *
FROM employee_demographics
ORDER BY age DESC;
-- Donna is 3rd oldest here - let's grab just her row:
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;

-- ---------------------------------------------------------------------------
-- Aliasing
-- ---------------------------------------------------------------------------

-- Aliasing renames a column (or table) in the output. It's also used
-- extensively with joins, which we'll cover in the intermediate lessons.

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

-- Use the AS keyword to alias a column
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender;

-- AS is optional but makes the intent explicit, which is usually preferred
SELECT gender, AVG(age) avg_age
FROM employee_demographics
GROUP BY gender;
