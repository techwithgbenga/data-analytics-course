-- =============================================================================
-- Exercises: Intermediate
-- Uses `parks_and_recreation` and `bakery` - run both scripts in
-- sql/00_setup first. Write your own query under each prompt, then compare
-- against 02_intermediate_solutions.sql when you're done.
-- =============================================================================

USE parks_and_recreation;

-- 1. Join employee_demographics and employee_salary on employee_id, showing
--    first_name, last_name, age, and salary for every employee that has a
--    match in both tables.


-- 2. Using a LEFT JOIN from employee_salary to employee_demographics, list
--    every employee in employee_salary along with their age (NULL if unknown).


-- 3. Join employee_salary to parks_departments to show each employee's name
--    alongside their department_name. Employees with no department should
--    still appear, with a NULL department_name.


-- 4. Using bakery.customers, return each customer's first_name in
--    UPPERCASE and the LENGTH of their first_name.


-- 5. Using bakery.customers, return each customer's phone number with
--    whitespace trimmed off both ends.


-- 6. Write a CASE statement against employee_demographics that labels each
--    employee "Adult" if age < 65, otherwise "Senior".


-- 7. Using a subquery, find all employees in employee_demographics whose
--    employee_id also appears in employee_salary with a salary >= 65000.


-- 8. Using UNION, combine a list of employees older than 45 (label them
--    'Senior') with a list of employees earning over 70000 (label them
--    'High Earner'). Each result row should have first_name, last_name,
--    and the label.


-- 9. Using a window function, show every employee's salary next to the
--    average salary for their gender, without collapsing rows (i.e. don't
--    use GROUP BY).


-- 10. Using RANK() OVER (...), rank employees within each department
--     (dept_id) by salary, highest first.
