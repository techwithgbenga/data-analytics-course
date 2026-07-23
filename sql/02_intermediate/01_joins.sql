-- =============================================================================
-- Intermediate: JOINs
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- Joins let you combine two (or more) tables that share a common column. The
-- column names don't need to match - what matters is that the data in them
-- refers to the same thing. We'll look at inner joins, outer joins, and self joins.

USE parks_and_recreation;

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- ---------------------------------------------------------------------------
-- INNER JOIN - returns only rows that match in both tables
-- ---------------------------------------------------------------------------

-- Since both tables have overlapping column names, we specify which table each
-- column comes from using table.column notation.
SELECT *
FROM employee_demographics
JOIN employee_salary
    ON employee_demographics.employee_id = employee_salary.employee_id;

-- Notice Ron Swanson isn't in the results - he has no matching row in
-- employee_demographics, so an inner join drops him.

-- Aliasing tables makes this much easier to read:
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- ---------------------------------------------------------------------------
-- OUTER JOINS - LEFT and RIGHT
-- ---------------------------------------------------------------------------

-- A LEFT JOIN keeps every row from the left table, matching in rows from the
-- right table where possible (NULLs where there's no match).
SELECT *
FROM employee_salary sal
LEFT JOIN employee_demographics dem
    ON dem.employee_id = sal.employee_id;
-- Now Ron Swanson shows up, with NULLs for all the demographics columns since
-- there's no matching row on the right side.

-- A RIGHT JOIN is the mirror image - it keeps every row from the right table.
-- Here it ends up looking like an inner join, because every row in
-- employee_demographics already has a match in employee_salary.
SELECT *
FROM employee_salary sal
RIGHT JOIN employee_demographics dem
    ON dem.employee_id = sal.employee_id;

-- ---------------------------------------------------------------------------
-- SELF JOIN - joining a table to itself
-- ---------------------------------------------------------------------------

SELECT *
FROM employee_salary;

-- Let's set up a "secret santa" pairing, where the employee with the next
-- highest ID is assigned as the secret santa for the current employee.
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
    ON emp1.employee_id + 1 = emp2.employee_id;

SELECT emp1.employee_id AS emp_santa,
       emp1.first_name AS santa_first_name,
       emp1.last_name AS santa_last_name,
       emp2.employee_id,
       emp2.first_name,
       emp2.last_name
FROM employee_salary emp1
JOIN employee_salary emp2
    ON emp1.employee_id + 1 = emp2.employee_id;
-- Leslie is Ron's secret santa, and so on down the list. Notice the employee
-- with the highest ID doesn't get a match, since there's no "next" employee.

-- ---------------------------------------------------------------------------
-- Joining multiple tables
-- ---------------------------------------------------------------------------

SELECT *
FROM parks_departments;

SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
JOIN parks_departments dept
    ON dept.department_id = sal.dept_id;
-- Because this chain uses inner joins, Andy Dwyer drops out - he isn't
-- assigned to any department (dept_id is NULL).

-- Switching the last join to a LEFT JOIN keeps him, since we're taking
-- everything from the left side of that join (the salary/demographics result):
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
    ON dept.department_id = sal.dept_id;
