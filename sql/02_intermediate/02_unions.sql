-- =============================================================================
-- Intermediate: UNIONs
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- A UNION combines rows from multiple queries into one result set - stacked
-- on top of each other, unlike a JOIN which combines columns side by side.
-- Each SELECT in a UNION must return the same number of columns, and the
-- columns should represent the same kind of data (even though MySQL won't
-- stop you from mixing unrelated data).

USE parks_and_recreation;

-- Just to illustrate the mechanics, here's a union of two unrelated column
-- pairs - notice how the data gets combined into one column, not two:
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT occupation, salary
FROM employee_salary;

-- A more sensible example - combining actual first/last names from both tables
SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;
-- Notice duplicate rows get removed. UNION is shorthand for UNION DISTINCT.

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;

-- Use UNION ALL to keep duplicates
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;

-- ---------------------------------------------------------------------------
-- A realistic use case
-- ---------------------------------------------------------------------------

-- The Parks Department is trying to trim its budget and wants to flag older
-- employees and highly paid employees as candidates for negotiation. Let's
-- build one combined report using UNION and a label column for each group.

SELECT first_name, last_name, 'Older Employee' AS label
FROM employee_demographics
WHERE age > 50;

SELECT first_name, last_name, 'Older Woman' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Older Man'
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Highly Paid Employee'
FROM employee_salary
WHERE salary >= 70000
ORDER BY first_name;
