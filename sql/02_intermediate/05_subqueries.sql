-- =============================================================================
-- Intermediate: Subqueries
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- A subquery is a query nested inside another query.

USE parks_and_recreation;

SELECT *
FROM employee_demographics;

-- Let's find employees who work in the Parks and Rec department (dept_id = 1).
-- We could do this with a JOIN, or with a subquery in the WHERE clause:
SELECT *
FROM employee_demographics
WHERE employee_id IN
    (SELECT employee_id
     FROM employee_salary
     WHERE dept_id = 1);

-- If you run just the subquery on its own, it behaves like a simple list that
-- the outer query then filters against.

-- A subquery used with IN must return exactly one column. This would fail:
-- SELECT *
-- FROM employee_demographics
-- WHERE employee_id IN
--     (SELECT employee_id, salary
--      FROM employee_salary
--      WHERE dept_id = 1);
-- MySQL raises "Operand should contain 1 column(s)".

-- Subqueries can also appear in the SELECT and FROM clauses.

-- Say we want to compare each employee's salary to the overall average salary.
-- SELECT first_name, salary, AVG(salary)
-- FROM employee_salary;
-- This fails - you can't mix a plain column with an aggregate without a GROUP BY.

SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;
-- This "works" but gives the average PER GROUP (i.e. just the salary itself,
-- since every group only has one row) - not what we want.

-- A subquery in the SELECT clause solves this cleanly:
SELECT first_name,
       salary,
       (SELECT AVG(salary) FROM employee_salary) AS company_avg_salary
FROM employee_salary;

-- Subqueries in the FROM clause act like a temporary, inline table you can
-- query against. This is sometimes called a "derived table".
SELECT *
FROM (SELECT gender, MIN(age), MAX(age), COUNT(age), AVG(age)
      FROM employee_demographics
      GROUP BY gender) AS agg_table;
-- Derived tables MUST be given an alias (agg_table here) or MySQL will error.

SELECT gender, AVG(min_age)
FROM (SELECT gender,
             MIN(age) min_age,
             MAX(age) max_age,
             COUNT(age) count_age,
             AVG(age) avg_age
      FROM employee_demographics
      GROUP BY gender) AS agg_table
GROUP BY gender;
