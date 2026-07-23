-- =============================================================================
-- Intermediate: Window Functions
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- Window functions are similar to GROUP BY in that they operate over a group
-- ("window") of rows, but instead of collapsing each group into a single row,
-- they keep every original row and attach the calculated value to it.
-- We'll also look at ROW_NUMBER, RANK, and DENSE_RANK.

USE parks_and_recreation;

-- First, a reminder of what GROUP BY gives us: one row per gender.
SELECT gender, ROUND(AVG(salary), 1)
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
GROUP BY gender;

-- Now the same calculation as a window function - every employee's row is
-- preserved, each annotated with the overall average salary:
SELECT dem.employee_id, dem.first_name, gender, salary,
       AVG(salary) OVER () AS overall_avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- PARTITION BY works like GROUP BY, but again without collapsing rows - it
-- just resets the calculation for each partition (group).
SELECT dem.employee_id, dem.first_name, gender, salary,
       AVG(salary) OVER (PARTITION BY gender) AS avg_salary_by_gender
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Adding ORDER BY inside the window turns it into a running/rolling
-- calculation - here, a running total of salary per gender, ordered by
-- employee_id:
SELECT dem.employee_id, dem.first_name, gender, salary,
       SUM(salary) OVER (PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- ---------------------------------------------------------------------------
-- ROW_NUMBER, RANK, and DENSE_RANK
-- ---------------------------------------------------------------------------

SELECT dem.employee_id, dem.first_name, gender, salary,
       ROW_NUMBER() OVER (PARTITION BY gender) AS row_num
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Order by salary to see the ranking of highest-paid employees per gender
SELECT dem.employee_id, dem.first_name, gender, salary,
       ROW_NUMBER() OVER (PARTITION BY gender ORDER BY salary DESC) AS row_num
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Compare ROW_NUMBER to RANK
SELECT dem.employee_id, dem.first_name, gender, salary,
       ROW_NUMBER() OVER (PARTITION BY gender ORDER BY salary DESC) AS row_num,
       RANK()       OVER (PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;
-- RANK gives tied rows the same rank, then skips the next rank number(s) to
-- account for the tie (e.g. two rows tied for 5th means the next rank is 7th).

-- Compare both to DENSE_RANK
SELECT dem.employee_id, dem.first_name, gender, salary,
       ROW_NUMBER() OVER (PARTITION BY gender ORDER BY salary DESC) AS row_num,
       RANK()       OVER (PARTITION BY gender ORDER BY salary DESC) AS rank_num,
       DENSE_RANK() OVER (PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;
-- DENSE_RANK doesn't skip numbers after a tie - it's a consecutive, purely
-- numeric ranking rather than a positional one.
