-- By definition, data cleaning is the task of cleaning up raw data to make it usable and ready for analysis.
-- Normalization: Standardizing or “cleaning up a column” by transforming it in some way to make it ready for analysis. A few normalization techniques are below:

-- Adjusting a column that includes multiple currencies to one common currency
-- Adjusting the varied distribution of a column value by transforming it into a z-score
-- Converting all price into a common metric (e.g., price per ounce)

-- when going about your data cleaning task

What data do you need?
What data do you have?
How will you clean your data?
How will you analyze your data?

-- The following set of methods cover three types of data cleaning techniques: 
-- parsing information, 
-- returning where information lives, and 

-- changing the data type of the information.

-- Left: Extracts a number of characters from a string starting from the left
-- Right: Extracts a number of characters from a string starting from the right
-- Substr: Extracts a substring from a string (starting at any position)
-- Position: Returns the position of the first occurrence of a substring in a string
-- Strpos: Returns the position of a substring within a string
-- Concat: Adds two or more expressions together
-- Cast: Converts a value of any type into a specific, different data type
-- Coalesce: Returns the first non-null value in a list

LEFT(student_information, 8) AS student_id
RIGHT(student_information, 6) AS salary

SUBSTR(string, start, length)
SUBSTR(student_information, 11, 1) AS gender

SELECT RIGHT(website, 3) AS domain, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                          THEN 1 ELSE 0 END AS num, 
            CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                          THEN 0 ELSE 1 END AS letter
         FROM accounts) t1;

SELECT SUM(vowels) vowels, SUM(other) other
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                           THEN 1 ELSE 0 END AS vowels, 
             CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                          THEN 0 ELSE 1 END AS other
            FROM accounts) t1;


WITH table AS(
SELECT  student_information,
        value,
        ROW _NUMBER() OVER(PARTITION BY student_information ORDER BY (SELECT NULL)) AS row_number
FROM    student_db
        CROSS APPLY STRING_SPLIT(student_information, ',') AS back_values
)
SELECT  student_information,
        [1] AS STUDENT_ID,
        [2] AS GENDER,
        [3] AS CITY,
        [4] AS GPA,
        [5] AS SALARY
FROM    table
PIVOT(
        MAX(VALUE)
        FOR row_number IN([1],[2],[3],[4],[5])
) AS PVT)


