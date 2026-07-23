-- =============================================================================
-- Intermediate: String Functions
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql AND
--     sql/00_setup/02_create_bakery_db.sql first.
-- =============================================================================

-- String functions let us inspect and transform text values.

SELECT *
FROM bakery.customers;

-- LENGTH returns the number of characters in a string
SELECT LENGTH('sky');

SELECT first_name, LENGTH(first_name)
FROM parks_and_recreation.employee_demographics;

-- UPPER / LOWER change the case of a string
SELECT UPPER('sky');

SELECT first_name, UPPER(first_name)
FROM parks_and_recreation.employee_demographics;

SELECT LOWER('sky');

SELECT first_name, LOWER(first_name)
FROM parks_and_recreation.employee_demographics;

-- TRIM removes whitespace from both ends of a string. Notice the bakery
-- customers table has a phone number with leading/trailing spaces:
SELECT phone, TRIM(phone) AS trimmed_phone
FROM bakery.customers;

-- TRIM only strips whitespace from the outer edges, not the middle:
SELECT TRIM('     I           love          SQL');

-- LTRIM / RTRIM trim just the left or right side
SELECT LTRIM('     I love SQL');
SELECT RTRIM('I love SQL    ');

-- LEFT takes a specified number of characters from the left side of a string
SELECT LEFT('Alexander', 4);

SELECT first_name, LEFT(first_name, 4)
FROM parks_and_recreation.employee_demographics;

-- RIGHT does the same thing from the right side
SELECT RIGHT('Alexander', 6);

SELECT first_name, RIGHT(first_name, 4)
FROM parks_and_recreation.employee_demographics;

-- SUBSTRING lets you grab characters from anywhere in a string by specifying
-- a starting position and a length. Very useful in real analysis work.
SELECT SUBSTRING('Alexander', 2, 3);

-- For example, pulling the year out of a date string:
SELECT birth_date, SUBSTRING(birth_date, 1, 4) AS birth_year
FROM parks_and_recreation.employee_demographics;

-- REPLACE swaps every occurrence of one substring for another
SELECT REPLACE(first_name, 'a', 'z')
FROM parks_and_recreation.employee_demographics;

-- LOCATE returns the position of a substring within a string
SELECT LOCATE('x', 'Alexander');

-- If a character appears more than once, LOCATE returns the position of the
-- FIRST occurrence only. "Alexander" has two e's:
SELECT LOCATE('e', 'Alexander');

SELECT first_name, LOCATE('a', first_name)
FROM parks_and_recreation.employee_demographics;

-- You can locate longer substrings too, not just single characters
SELECT first_name, LOCATE('Mic', first_name)
FROM bakery.customers;

-- CONCAT combines multiple strings together
SELECT CONCAT('Alex', 'Freberg');

-- A very common use: combining first and last name into a full name
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM parks_and_recreation.employee_demographics;
