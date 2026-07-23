-- =============================================================================
-- Beginner: The SELECT Statement
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- The SELECT statement is used to choose which columns you want to see in
-- your output. We'll cover the basics here; there's a lot more to SELECT
-- that we'll build on throughout the course.

USE parks_and_recreation;

-- We can select every column using *
SELECT *
FROM employee_demographics;

-- Or select a specific column
SELECT first_name
FROM employee_demographics;

-- As you can see from the output, we only get the one column now.

-- We can select multiple columns by separating them with commas
SELECT first_name, last_name
FROM employee_demographics;

-- The order of the columns in the SELECT statement doesn't usually matter -
-- you can list them in whatever order you want to see them in the output.
SELECT last_name, first_name, gender, age
FROM employee_demographics;

-- You'll often see SQL formatted like this, with each column on its own line:
SELECT last_name,
       first_name,
       gender,
       age
FROM employee_demographics;

-- The query runs exactly the same either way, but this is easier to read and
-- makes it simple to pick out which columns are being selected.

-- You can also perform calculations directly in the SELECT statement.
-- Here we add 100 to every customer's total_money_spent:
SELECT first_name,
       last_name,
       total_money_spent,
       total_money_spent + 100
FROM customers;

-- Math in SQL follows the standard order of operations (PEMDAS: Parentheses,
-- Exponents, Multiplication/Division, Addition/Subtraction).

-- What will the output be here?
SELECT first_name,
       last_name,
       salary,
       salary + 100
FROM employee_salary;
-- salary + 100 is calculated for each row - it's not "10 * 100" or anything
-- fancier, just simple addition applied per row.

-- Now what changes if we add parentheses?
SELECT first_name,
       last_name,
       salary,
       (salary + 100) * 10
FROM employee_salary;
-- The parentheses force salary + 100 to be evaluated first, then multiplied by 10.

-- DISTINCT returns only unique values in the output - no duplicates.
SELECT dept_id
FROM employee_salary;

SELECT DISTINCT dept_id
FROM employee_salary;

-- That's the core of the SELECT statement. We'll keep building on it - WHERE,
-- GROUP BY, joins, and more - throughout the rest of the course.
