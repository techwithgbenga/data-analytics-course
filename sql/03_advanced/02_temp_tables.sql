-- =============================================================================
-- Advanced: Temporary Tables
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

-- Temporary tables are only visible to the session (connection) that created
-- them, and they disappear automatically when that session ends. They're
-- useful for staging intermediate results in a complex, multi-step query, or
-- for manipulating data before writing it into a permanent table.

USE parks_and_recreation;

-- There are two ways to create a temp table:

-- ---------------------------------------------------------------------------
-- 1. Define the structure explicitly, like a real table (less common)
-- ---------------------------------------------------------------------------
CREATE TEMPORARY TABLE temp_favorite_movies (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);

SELECT *
FROM temp_favorite_movies;
-- It's empty right now, and if you refresh your schema browser, you won't
-- see it listed - it only exists in memory for this session.

INSERT INTO temp_favorite_movies
VALUES ('Alex', 'Freberg', 'Lord of the Rings: The Two Towers');

SELECT *
FROM temp_favorite_movies;

-- ---------------------------------------------------------------------------
-- 2. Create it directly from a query's result (faster, and the more common
--    approach in practice)
-- ---------------------------------------------------------------------------
CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT *
FROM salary_over_50k;

-- This is the pattern you'll see most often: querying data and staging a
-- filtered/transformed slice of it into a temp table to build on further.
