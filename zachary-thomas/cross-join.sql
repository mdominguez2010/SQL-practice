-- PART 1:
-- *Context:* Say we have a table state_streams where each row is a state and
-- the total number of hours of streaming from a video hosting service:
| state | total_streams |b.state|b.total_streams|
|-------|---------------|
| NC    | 34569         | SC    | 33999         | diff < 1000
| SC    | 33999         | NC    | 34569         |
| CA    | 98324         |
| MA    | 19345         |
| ..    | ..            |
-- *Task:* Write a query to get the pairs of states with
-- total streaming amounts within 1000 of each other.
-- For the snippet above, we would want to see something like:
| state_a | state_b | diff |
|---------|---------|------|
| NC      | SC      | 500  |
| SC      | NC      |-500  |

SELECT
    a.state AS state_a,
    b.state AS state_b
FROM
    state_streams a
    CROSS JOIN
        state_streams b
WHERE
    ABS(a.total_streams - b.total_streams) < 1000
    AND
        a.state <> b.state
    AND
        a.total_streams - b.total_streams > 0;

-- Part 2: 

-- *Note:* This question is considered more of a bonus problem than an actual SQL pattern.
-- Feel free to skip it!
-- *Task:* How could you modify the
-- SQL from the solution to Part 1 of this question so that duplicates are removed?
-- For example, if we used the sample table from Part 1,
-- the pair NC and SC should only appear in one row instead of two. 
