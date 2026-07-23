-- =============================================================================
-- Beginner: GROUP BY and ORDER BY
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

USE parks_and_recreation;

-- ---------------------------------------------------------------------------
-- GROUP BY
-- ---------------------------------------------------------------------------

-- GROUP BY groups together rows that share the same value(s) in the
-- specified column(s), so you can run aggregate functions (COUNT, AVG, etc.)
-- on each group.

SELECT *
FROM employee_demographics;

-- Any column you SELECT that isn't inside an aggregate function generally
-- needs to appear in the GROUP BY clause.
SELECT gender
FROM employee_demographics
GROUP BY gender;

SELECT occupation
FROM employee_salary
GROUP BY occupation;
-- Notice there's only one "Office Manager" row - GROUP BY collapses
-- duplicates in the grouped column(s).

-- Grouping by 2 columns gives a row per unique combination
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;

-- The real power of GROUP BY is running aggregate functions per group
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

SELECT gender, MIN(age), MAX(age), COUNT(age), AVG(age)
FROM employee_demographics
GROUP BY gender;

-- ---------------------------------------------------------------------------
-- ORDER BY
-- ---------------------------------------------------------------------------

-- ORDER BY sorts the result set. Ascending (A-Z, low-high) is the default.

SELECT *
FROM customers
ORDER BY first_name;

-- Use DESC to sort in descending order instead
SELECT *
FROM employee_demographics
ORDER BY first_name;

SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

-- You can order by multiple columns
SELECT *
FROM employee_demographics
ORDER BY gender, age;

SELECT *
FROM employee_demographics
ORDER BY gender DESC, age DESC;

-- You can also reference columns by their position in the SELECT list instead
-- of spelling out the name. Here, gender is the 5th column selected and age
-- is the 4th:
SELECT *
FROM employee_demographics
ORDER BY 5 DESC, 4 DESC;
-- Best practice is to use column names, not positions - it's more explicit,
-- and it keeps working correctly if columns get added/reordered later.
