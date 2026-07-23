-- =============================================================================
-- Intermediate: CASE Statements
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- A CASE statement adds if/else-style logic to a SELECT statement, similar to
-- an IF/ELSE in other programming languages, or a nested IF() in Excel.

USE parks_and_recreation;

SELECT *
FROM employee_demographics;

SELECT first_name,
       last_name,
       CASE
           WHEN age <= 30 THEN 'Young'
       END
FROM employee_demographics;

-- Add more branches with additional WHEN clauses
SELECT first_name,
       last_name,
       CASE
           WHEN age <= 30 THEN 'Young'
           WHEN age BETWEEN 31 AND 50 THEN 'Middle-Aged'
           WHEN age > 50 THEN 'Senior'
       END AS age_group
FROM employee_demographics;

-- CASE can also drive calculations, not just labels. Let's apply a raise and
-- bonus structure to employee_salary.

SELECT *
FROM employee_salary;

-- Pawnee City Council's new pay policy:
--   - Employees making less than $45k get a 7% raise
--   - Employees making $45k or more get a 5% raise
--   - Employees in the Finance department (dept_id = 6) also get a 10% bonus

SELECT first_name, last_name, salary,
       CASE
           WHEN salary >= 45000 THEN salary + (salary * 0.05)
           WHEN salary < 45000 THEN salary + (salary * 0.07)
       END AS new_salary
FROM employee_salary;

-- Now let's add the bonus as its own column
SELECT first_name, last_name, salary,
       CASE
           WHEN salary >= 45000 THEN salary + (salary * 0.05)
           WHEN salary < 45000 THEN salary + (salary * 0.07)
       END AS new_salary,
       CASE
           WHEN dept_id = 6 THEN salary * 0.10
       END AS bonus
FROM employee_salary;
-- Ben Wyatt (State Auditor, Finance) is the only one who qualifies for a bonus.
