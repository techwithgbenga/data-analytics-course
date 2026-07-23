-- =============================================================================
-- Advanced: Indexes and Query Performance  (NEW LESSON)
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- An index is a data structure that lets MySQL find rows without scanning the
-- entire table - similar to an index at the back of a book. Indexes speed up
-- reads (especially WHERE, JOIN, and ORDER BY) at the cost of extra storage
-- and slightly slower writes (since the index has to be updated too).

USE parks_and_recreation;

-- EXPLAIN shows you the query plan MySQL intends to use - which indexes (if
-- any) it will use, how many rows it expects to examine, join order, etc.
-- Run this before and after adding indexes to see the difference.
EXPLAIN
SELECT *
FROM employee_salary
WHERE occupation = 'Office Manager';

-- On our tiny sample tables you won't see a dramatic difference, but on a
-- table with millions of rows, a WHERE clause on an unindexed column forces
-- a full table scan.

-- Create a single-column index
CREATE INDEX idx_employee_salary_occupation
    ON employee_salary (occupation);

EXPLAIN
SELECT *
FROM employee_salary
WHERE occupation = 'Office Manager';
-- The `key` column in the EXPLAIN output should now show the new index
-- being used instead of a full scan.

-- A composite (multi-column) index helps when you frequently filter/sort on
-- more than one column together. Column ORDER matters - put the column you
-- filter on most selectively (or most often) first.
CREATE INDEX idx_employee_salary_dept_salary
    ON employee_salary (dept_id, salary);

EXPLAIN
SELECT *
FROM employee_salary
WHERE dept_id = 1
ORDER BY salary DESC;

-- PRIMARY KEYs and, in many cases, FOREIGN KEYs are indexed automatically.
-- Only add extra indexes for columns you actually filter/join/sort on
-- frequently - every index adds write overhead and storage, so indexing
-- everything "just in case" is a common performance anti-pattern.

SHOW INDEX FROM employee_salary;

-- Indexes are dropped like this:
-- DROP INDEX idx_employee_salary_occupation ON employee_salary;
-- DROP INDEX idx_employee_salary_dept_salary ON employee_salary;
