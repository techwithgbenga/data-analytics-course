-- =============================================================================
-- Advanced: Stored Procedures
-- Run sql/00_setup/01_create_parks_and_recreation_db.sql first.
-- =============================================================================

USE parks_and_recreation;

-- Let's start with a plain query
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- Now let's turn it into a stored procedure
DROP PROCEDURE IF EXISTS large_salaries;
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- Creating it produces no output - that's expected. Call it to run it:
CALL large_salaries();

-- ---------------------------------------------------------------------------
-- Multiple statements: DELIMITER, BEGIN...END
-- ---------------------------------------------------------------------------

-- A single-statement procedure like above is rarely how it's done in
-- practice. Real stored procedures usually run several statements. If you
-- try to just tack on a second query, it gets parsed as a separate statement
-- outside the procedure entirely - it won't be included.

-- The fix is to change the DELIMITER before defining the procedure, and wrap
-- the statements in BEGIN...END. Changing the delimiter (commonly to `$$`)
-- tells MySQL "don't treat a semicolon as the end of this whole block" -
-- only the new delimiter ends it.
DROP PROCEDURE IF EXISTS large_salaries2;
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 60000;

    SELECT *
    FROM employee_salary
    WHERE salary >= 50000;
END $$
DELIMITER ;
-- Always change the delimiter back to `;` afterward so the rest of your
-- script behaves normally.

CALL large_salaries2();
-- This returns two result sets - one per query inside the procedure.

-- ---------------------------------------------------------------------------
-- Parameters
-- ---------------------------------------------------------------------------

-- Stored procedures can accept parameters, letting you reuse the same logic
-- with different inputs.
DROP PROCEDURE IF EXISTS large_salaries_by_id;
DELIMITER $$
CREATE PROCEDURE large_salaries_by_id(IN employee_id_param INT)
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 60000
      AND employee_id = employee_id_param;
END $$
DELIMITER ;

CALL large_salaries_by_id(1);
CALL large_salaries_by_id(8);

-- In MySQL Workbench, you can also right-click "Stored Procedures" in the
-- schema browser and choose "Create Stored Procedure..." - it will
-- automatically scaffold the DELIMITER / BEGIN / END boilerplate for you.
