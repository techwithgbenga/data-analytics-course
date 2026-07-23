-- =============================================================================
-- Intermediate: Views  (NEW LESSON)
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- A VIEW is a saved query you can treat like a virtual table. It doesn't
-- store data itself - every time you query it, it re-runs the underlying
-- query. Views are great for reusing complex logic (like multi-table joins)
-- without retyping it, and for controlling what data different users can see.

USE parks_and_recreation;

-- Let's save our department salary join as a view
CREATE OR REPLACE VIEW employee_department_salaries AS
SELECT dem.employee_id,
       dem.first_name,
       dem.last_name,
       sal.occupation,
       sal.salary,
       dept.department_name
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
    ON dept.department_id = sal.dept_id;

-- Now we can query it exactly like a table
SELECT *
FROM employee_department_salaries;

SELECT department_name, AVG(salary)
FROM employee_department_salaries
GROUP BY department_name;

-- Views can also restrict which columns/rows are visible - useful for
-- sharing a limited slice of sensitive data (e.g. hiding salary figures):
CREATE OR REPLACE VIEW employee_directory AS
SELECT employee_id, first_name, last_name, occupation, department_name
FROM employee_department_salaries;

SELECT *
FROM employee_directory;

-- SHOW CREATE VIEW lets you see the underlying query behind a view
SHOW CREATE VIEW employee_department_salaries;

-- Views are dropped just like tables
-- DROP VIEW IF EXISTS employee_directory;
-- DROP VIEW IF EXISTS employee_department_salaries;
