-- =============================================================================
-- Portfolio Project 1: Data Cleaning - World Layoffs (2022-2023)
-- Run sql/00_setup/03_create_world_layoffs_db.sql first (and load the CSV).
--
-- Source dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022
-- =============================================================================

-- When cleaning data, we generally follow these steps:
--   1. Check for duplicates and remove them
--   2. Standardize data and fix formatting/spelling errors
--   3. Review NULL values and decide what (if anything) to do about them
--   4. Remove any columns/rows that aren't needed for analysis

USE world_layoffs;

SELECT *
FROM layoffs;

-- Always work off a staging copy so the raw imported data is preserved in
-- case anything goes wrong.
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- -----------------------------------------------------------------------
-- 1. Remove duplicates
-- -----------------------------------------------------------------------

-- This table has no unique ID column, so we detect duplicates by numbering
-- rows within groups of identical values. Any row numbered > 1 is a repeat.
SELECT *
FROM (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, location, industry, total_laid_off,
                         percentage_laid_off, `date`, stage, country,
                         funds_raised_millions
        ) AS row_num
    FROM layoffs_staging
) duplicates
WHERE row_num > 1;

-- MySQL doesn't allow DELETE directly against a CTE/derived table that
-- references the same table you're deleting from, so the cleanest fix is to
-- persist the row numbers into a real staging table, then delete from that.

CREATE TABLE layoffs_staging2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT,
    row_num INT
);

INSERT INTO layoffs_staging2
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off,
                     percentage_laid_off, `date`, stage, country,
                     funds_raised_millions
    ) AS row_num
FROM layoffs_staging;

DELETE FROM layoffs_staging2
WHERE row_num > 1;

SELECT * FROM layoffs_staging2;

-- -----------------------------------------------------------------------
-- 2. Standardize data
-- -----------------------------------------------------------------------

-- `industry` has some NULL/blank values. Standardize blanks to NULL first,
-- since NULL is generally easier to work with than an empty string.
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Some companies have a NULL industry on one row but a populated industry on
-- another row for the same company. Backfill NULLs using matching rows.
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- "Crypto", "Crypto Currency", and "CryptoCurrency" are all the same
-- industry, just written inconsistently - standardize them.
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry;

-- `country` has both "United States" and "United States." (trailing period)
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY country;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- `date` was imported as text (e.g. "3/6/2023") - convert it to a real DATE
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT * FROM layoffs_staging2;

-- -----------------------------------------------------------------------
-- 3. Review NULL values
-- -----------------------------------------------------------------------

-- total_laid_off, percentage_laid_off, and funds_raised_millions all have
-- legitimate NULLs where the data simply wasn't reported. We leave these as
-- NULL (rather than 0) since that makes aggregate calculations in the EDA
-- phase more accurate - NULL is excluded from AVG/SUM automatically, while 0
-- would incorrectly pull those averages down.

-- -----------------------------------------------------------------------
-- 4. Remove columns/rows we don't need
-- -----------------------------------------------------------------------

-- Rows with no total_laid_off AND no percentage_laid_off carry no usable
-- signal for this analysis - safe to drop.
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- row_num was only a helper column for de-duplication - drop it now that
-- we're done with it.
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * FROM layoffs_staging2;

-- layoffs_staging2 is now the clean table to build the EDA on - see
-- sql/04_portfolio_projects/02_exploratory_data_analysis_world_layoffs.sql
