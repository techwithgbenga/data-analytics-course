-- =============================================================================
-- Exercises: Beginner - SOLUTIONS
-- Try 01_beginner_exercises.sql yourself first!
-- =============================================================================

USE parks_and_recreation;

-- 1. Select every column for every row in employee_demographics.
SELECT *
FROM employee_demographics;

-- 2. Select just the first_name and age columns from employee_demographics.
SELECT first_name, age
FROM employee_demographics;

-- 3. Select the distinct list of occupations from employee_salary.
SELECT DISTINCT occupation
FROM employee_salary;

-- 4. Find every employee in employee_demographics who is older than 40.
SELECT *
FROM employee_demographics
WHERE age > 40;

-- 5. Find every employee in employee_salary whose salary is between
--    50000 and 70000 (inclusive).
SELECT *
FROM employee_salary
WHERE salary BETWEEN 50000 AND 70000;

-- 6. Find every employee whose first name starts with the letter "A".
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'A%';

-- 7. For each gender in employee_demographics, show the average age,
--    rounded to 1 decimal place.
SELECT gender, ROUND(AVG(age), 1)
FROM employee_demographics
GROUP BY gender;

-- 8. Using employee_salary, show each department (dept_id) and its average
--    salary, but only include departments where the average salary is
--    above 50000.
SELECT dept_id, AVG(salary)
FROM employee_salary
GROUP BY dept_id
HAVING AVG(salary) > 50000;

-- 9. List all customers from the `customers` table, ordered by
--    total_money_spent from highest to lowest, and show only the top 3.
SELECT *
FROM customers
ORDER BY total_money_spent DESC
LIMIT 3;

-- 10. Rewrite query #7 so the average age column is aliased as `avg_age`.
SELECT gender, ROUND(AVG(age), 1) AS avg_age
FROM employee_demographics
GROUP BY gender;
