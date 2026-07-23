-- =============================================================================
-- Advanced: Regular Expressions (REGEXP)  (NEW LESSON)
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql AND
--     sql/00_setup/02_create_bakery_db.sql first.
-- =============================================================================

-- REGEXP lets you match strings against a pattern - much more flexible than
-- LIKE's % and _ wildcards. MySQL 8+ uses ICU regular expression syntax.

USE parks_and_recreation;

-- Basic match: names containing a literal substring (same as LIKE '%and%')
SELECT first_name
FROM employee_demographics
WHERE first_name REGEXP 'and';

-- ^ anchors to the start of the string, $ anchors to the end
SELECT first_name
FROM employee_demographics
WHERE first_name REGEXP '^A';         -- starts with A

SELECT first_name
FROM employee_demographics
WHERE first_name REGEXP 'n$';         -- ends with n

-- Character classes: [aeiou] matches any single character in the set
SELECT first_name
FROM employee_demographics
WHERE first_name REGEXP '^[AJ]';      -- starts with A or J

-- The pipe | acts as OR between patterns
SELECT first_name
FROM employee_demographics
WHERE first_name REGEXP 'Tom|Ann|Ben';

-- {n} / {n,m} specify how many times the previous character/group repeats.
-- Here we validate that a phone number looks like NNN-NNN-NNNN:
SELECT phone
FROM bakery.customers
WHERE phone REGEXP '^ *[0-9]{3}-[0-9]{3}-[0-9]{4} *$';

-- REGEXP_REPLACE (MySQL 8+) lets you substitute matched text - handy for
-- cleaning up messy data. Here we strip out anything that isn't a digit:
SELECT phone, REGEXP_REPLACE(phone, '[^0-9]', '') AS digits_only
FROM bakery.customers;

-- REGEXP_LIKE is a function-style equivalent to the REGEXP operator, useful
-- when you want a boolean 0/1 result instead of filtering rows:
SELECT email, REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$') AS looks_valid
FROM bakery.customers;
