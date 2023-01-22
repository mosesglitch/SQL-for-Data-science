-- Nested Query
-- When a user wants to filter an output using a condition met from another table.
-- This type of placement also has advantages for making the code easy to read.

SELECT *
FROM students
WHERE student_id
IN (SELECT DISTINCT student_id
    FROM gpa_table
    WHERE gpa>3.5
    );

-- Use Case for Inline Subquery
-- It is a very similar use case to ‘With’ subqueries.
-- Inline subqueries create a “pseudo table” that aggregates or manipulates an existing table to be used in a larger query.

SELECT dept_name,
       max_gpa
FROM department_db x
     (SELECT dept_id
             MAX(gpa) as max_gpa
      FROM students
      GROUP BY dept_id
      )y
WHERE x.dept_id = y.dept_id
ORDER BY dept_name;

-- Use Case for Scalar subquery placement
-- It selects only one column or expression and returns one row, used in the select clause of the main query
-- It has the advantage of performance or if the data set is small
-- Details:
-- If a scalar subquery does not find a match, it returns a NULL.
-- If a scalar subquery finds multiple matches, it returns an ERROR.


-- Subquery Facts to Know:

-- Commonly used as a filter/aggregation tool
-- Commonly used to create a “temporary” view that can be queried off
-- Commonly used to increase readability
-- Can stand independently
