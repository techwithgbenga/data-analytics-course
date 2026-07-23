-- =============================================================================
-- Beginner: HAVING vs. WHERE
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- WHERE and HAVING both filter rows, but they filter at different stages:
--   WHERE  filters individual rows BEFORE grouping happens
--   HAVING filters groups AFTER aggregation/GROUP BY happens

USE parks_and_recreation;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

-- Let's try filtering on the aggregated average age using WHERE:
-- SELECT gender, AVG(age)
-- FROM employee_demographics
-- WHERE AVG(age) > 40
-- GROUP BY gender;
-- This fails. On the backend, WHERE is evaluated before GROUP BY, so you
-- can't filter on an aggregate that hasn't been calculated yet. That's
-- exactly why HAVING exists.

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

-- You can also filter using an alias for the aggregate column
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;
