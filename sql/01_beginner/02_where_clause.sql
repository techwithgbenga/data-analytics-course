-- =============================================================================
-- Beginner: The WHERE Clause
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- WHERE filters records (rows) based on a condition. It only affects which
-- rows show up in the output - it doesn't affect which columns you see.
-- For example, "WHERE first_name = 'Leslie'" would only return rows where
-- first_name equals 'Leslie'.

USE parks_and_recreation;

SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM employee_demographics
WHERE gender = 'Female';

-- != means "not equal to"
SELECT *
FROM employee_demographics
WHERE gender != 'Female';

-- WHERE also works with date values
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';
-- 'YYYY-MM-DD' is the default date format in MySQL. We'll cover other date
-- formats and functions later in sql/02_intermediate/07_date_and_time_functions.sql.

-- ---------------------------------------------------------------------------
-- The LIKE operator and wildcards
-- ---------------------------------------------------------------------------

-- LIKE lets you pattern-match strings using two special characters:
--   %  matches any number of characters (including zero)
--   _  matches exactly one character

-- Names that start with "a" followed by anything
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';

-- Names that start with "a" followed by exactly two more characters (3 letters total)
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';

-- Names that start with "a", then 3 more characters, then anything after that
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%';
