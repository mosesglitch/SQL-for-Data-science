




Details of UNION
There must be the same number of expressions in both SELECT statements.
The corresponding expressions must have the same data type in the SELECT statements.
For example:
Expression1 must be the same data type in both the first and second SELECT statement.
Expert Tip
UNION removes duplicate rows.
UNION ALL does not remove duplicate rows.

CREATE VIEW web_events_2
AS (SELECT * FROM web_events)

SELECT *
FROM web_events
UNION
SELECT *
FROM web_events_2

CREATE VIEW web_events_2
AS (SELECT * FROM web_events)

SELECT *
FROM web_events
WHERE channel = 'facebook'
UNION ALL
SELECT *
FROM web_events_2

CREATE VIEW web_events_2
AS (SELECT * FROM web_events)

SELECT channel,
       COUNT(*) AS sessions
FROM (
      SELECT *
      FROM web_events
      UNION ALL
      SELECT *
      FROM web_events_2
     ) web_events
GROUP BY 1
ORDER BY 2 DESC

CREATE VIEW web_events_2
AS (SELECT * FROM web_events)

WITH web_events AS (
      SELECT *
      FROM web_events
      UNION ALL
      SELECT *
      FROM web_events_2
     )
SELECT channel,
       COUNT(*) AS sessions
FROM  web_events
GROUP BY 1
ORDER BY 2 DESC