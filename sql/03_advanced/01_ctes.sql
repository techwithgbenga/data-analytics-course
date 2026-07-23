-- =============================================================================
-- Advanced: Common Table Expressions (CTEs)
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- A CTE defines a named, temporary result set that you can reference within
-- the query that follows it. It's similar to a subquery in the FROM clause,
-- but generally more readable, and it's required for recursive queries
-- (queries that reference a higher/previous level of themselves).

USE parks_and_recreation;

-- CTEs start with the WITH keyword, followed by a name you choose, then AS
-- and the query in parentheses. Immediately after, you query the CTE like a table.
WITH cte_salary_stats AS (
    SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary), AVG(salary)
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT *
FROM cte_salary_stats;

-- A CTE only exists for the single statement that follows it - you can't
-- come back later in a script and query it again without redefining it.

-- You can use the CTE's columns to do further calculations that would
-- otherwise require repeating the whole aggregate query.
WITH cte_salary_stats AS (
    SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
-- Unnamed aggregate columns need backticks to reference, since their default
-- name is literally the expression text (e.g. `SUM(salary)`):
SELECT gender, ROUND(AVG(`SUM(salary)` / `COUNT(salary)`), 2)
FROM cte_salary_stats
GROUP BY gender;

-- A single WITH clause can define multiple CTEs, separated by commas
WITH cte_young_employees AS (
    SELECT employee_id, gender, birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
),
cte_well_paid AS (
    SELECT employee_id, salary
    FROM employee_salary
    WHERE salary >= 50000
)
SELECT *
FROM cte_young_employees cte1
LEFT JOIN cte_well_paid cte2
    ON cte1.employee_id = cte2.employee_id;

-- You can rename a CTE's columns up front, which avoids the backtick issue
-- from earlier entirely:
WITH cte_salary_stats (gender, sum_salary, min_salary, max_salary, count_salary) AS (
    SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT gender, ROUND(AVG(sum_salary / count_salary), 2)
FROM cte_salary_stats
GROUP BY gender;
