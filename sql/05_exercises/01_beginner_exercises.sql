-- =============================================================================
-- Exercises: Beginner
-- Uses the `parks_and_recreation` database - run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- Write your own query under each prompt, then compare against
-- 01_beginner_solutions.sql when you're done.
-- =============================================================================

USE parks_and_recreation;

-- 1. Select every column for every row in employee_demographics.


-- 2. Select just the first_name and age columns from employee_demographics.


-- 3. Select the distinct list of occupations from employee_salary.


-- 4. Find every employee in employee_demographics who is older than 40.


-- 5. Find every employee in employee_salary whose salary is between
--    50000 and 70000 (inclusive).


-- 6. Find every employee whose first name starts with the letter "A".


-- 7. For each gender in employee_demographics, show the average age,
--    rounded to 1 decimal place.


-- 8. Using employee_salary, show each department (dept_id) and its average
--    salary, but only include departments where the average salary is
--    above 50000.


-- 9. List all customers from the `customers` table, ordered by
--    total_money_spent from highest to lowest, and show only the top 3.


-- 10. Rewrite query #7 so the average age column is aliased as `avg_age`.
