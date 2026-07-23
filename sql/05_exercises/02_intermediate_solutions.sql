-- =============================================================================
-- Exercises: Intermediate - SOLUTIONS
-- Try 02_intermediate_exercises.sql yourself first!
-- =============================================================================

USE parks_and_recreation;

-- 1. Join employee_demographics and employee_salary on employee_id, showing
--    first_name, last_name, age, and salary for every employee that has a
--    match in both tables.
SELECT dem.first_name, dem.last_name, dem.age, sal.salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- 2. Using a LEFT JOIN from employee_salary to employee_demographics, list
--    every employee in employee_salary along with their age (NULL if unknown).
SELECT sal.first_name, sal.last_name, dem.age
FROM employee_salary sal
LEFT JOIN employee_demographics dem
    ON sal.employee_id = dem.employee_id;

-- 3. Join employee_salary to parks_departments to show each employee's name
--    alongside their department_name. Employees with no department should
--    still appear, with a NULL department_name.
SELECT sal.first_name, sal.last_name, dept.department_name
FROM employee_salary sal
LEFT JOIN parks_departments dept
    ON sal.dept_id = dept.department_id;

-- 4. Using bakery.customers, return each customer's first_name in
--    UPPERCASE and the LENGTH of their first_name.
SELECT first_name, UPPER(first_name), LENGTH(first_name)
FROM bakery.customers;

-- 5. Using bakery.customers, return each customer's phone number with
--    whitespace trimmed off both ends.
SELECT phone, TRIM(phone) AS trimmed_phone
FROM bakery.customers;

-- 6. Write a CASE statement against employee_demographics that labels each
--    employee "Adult" if age < 65, otherwise "Senior".
SELECT first_name, last_name, age,
       CASE
           WHEN age < 65 THEN 'Adult'
           ELSE 'Senior'
       END AS age_label
FROM employee_demographics;

-- 7. Using a subquery, find all employees in employee_demographics whose
--    employee_id also appears in employee_salary with a salary >= 65000.
SELECT *
FROM employee_demographics
WHERE employee_id IN (
    SELECT employee_id
    FROM employee_salary
    WHERE salary >= 65000
);

-- 8. Using UNION, combine a list of employees older than 45 (label them
--    'Senior') with a list of employees earning over 70000 (label them
--    'High Earner'). Each result row should have first_name, last_name,
--    and the label.
SELECT first_name, last_name, 'Senior' AS label
FROM employee_demographics
WHERE age > 45
UNION
SELECT first_name, last_name, 'High Earner'
FROM employee_salary
WHERE salary > 70000;

-- 9. Using a window function, show every employee's salary next to the
--    average salary for their gender, without collapsing rows (i.e. don't
--    use GROUP BY).
SELECT dem.first_name, dem.gender, sal.salary,
       AVG(sal.salary) OVER (PARTITION BY dem.gender) AS avg_salary_by_gender
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- 10. Using RANK() OVER (...), rank employees within each department
--     (dept_id) by salary, highest first.
SELECT first_name, last_name, dept_id, salary,
       RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
FROM employee_salary;
