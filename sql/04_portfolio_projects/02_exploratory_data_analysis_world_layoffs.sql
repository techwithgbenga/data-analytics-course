-- =============================================================================
-- Portfolio Project 1: Exploratory Data Analysis - World Layoffs (2022-2023)
-- Run 01_data_cleaning_world_layoffs.sql first - this builds on layoffs_staging2.
-- =============================================================================

-- EDA is about exploring the data with no fixed destination in mind - looking
-- for trends, patterns, and outliers. Usually you go in with at least a rough
-- idea of what you're looking for; here, we're just seeing what we find.

USE world_layoffs;

SELECT *
FROM layoffs_staging2;

-- ---------------------------------------------------------------------------
-- Easier queries
-- ---------------------------------------------------------------------------

SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- percentage_laid_off ranges from 0 to 1 (i.e. 0% to 100% of the company)
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- Which companies laid off 100% of their staff (percentage_laid_off = 1)?
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1;
-- Mostly startups that shut down entirely during this period.

-- Sorting those by funds raised shows how large some of these companies were
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- Some had raised hundreds of millions (or more) before shutting down completely.

-- ---------------------------------------------------------------------------
-- Aggregation queries
-- ---------------------------------------------------------------------------

-- Companies with the single biggest layoff on one day
SELECT company, total_laid_off
FROM layoffs_staging2
ORDER BY total_laid_off DESC
LIMIT 5;

-- Companies with the most total layoffs across all reported dates
SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC
LIMIT 10;

-- By location
SELECT location, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY location
ORDER BY total_laid_off DESC
LIMIT 10;

-- By country (total across the entire dataset's date range)
SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;

-- By year
SELECT YEAR(`date`) AS `year`, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY `year`
ORDER BY `year`;

-- By industry
SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_laid_off DESC;

-- By company stage (Series A, Post-IPO, etc.)
SELECT stage, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_laid_off DESC;

-- ---------------------------------------------------------------------------
-- Tougher queries
-- ---------------------------------------------------------------------------

-- Top 3 companies by layoffs, per year. This needs a CTE + a window function:
-- first aggregate by company/year, then rank within each year.
WITH company_year AS (
    SELECT company, YEAR(`date`) AS `year`, SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
),
company_year_rank AS (
    SELECT company, `year`, total_laid_off,
           DENSE_RANK() OVER (PARTITION BY `year` ORDER BY total_laid_off DESC) AS ranking
    FROM company_year
)
SELECT company, `year`, total_laid_off, ranking
FROM company_year_rank
WHERE ranking <= 3
  AND `year` IS NOT NULL
ORDER BY `year`, total_laid_off DESC;

-- Rolling total of layoffs per month
WITH monthly_layoffs AS (
    SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY `month`
)
SELECT `month`,
       total_laid_off,
       SUM(total_laid_off) OVER (ORDER BY `month`) AS rolling_total_layoffs
FROM monthly_layoffs
ORDER BY `month`;
