--table sessions
| session_id | length_seconds |
|------------|----------------|
| 1          | 23             |
| 2          | 453            |
| 3          | 27             |
| ..         | ..             |
-- task: write a query to count the number of sessions that fall into banks
-- of size 5. Should produce the following table:
| bucket  | count |
|---------|-------|
| 20-25   | 2     |
| 450-455 | 1     |

| bucket  | count |
|---------|-------|
| 0-5     | 3     |
| ...     | ...   |
| 450-455 | 1     |
-- count(length_seconds) between 0 and 5
-- ...
-- count(length_seconds) between 450 and 5

WITH bin_label AS (
    SELECT
        session_id,
        FLOOR(lenght_seconds / 5) AS bin_label
    FROM
        sessions
)

SELECT
    CONCATENATE(STR(bin_label * 5), '-', STR(bin_label * 5 + 5)) AS bucket,
    COUNT(DISTINCT(session_id)) AS count_
FROM
    bin_label
GROUP BY
    bucket
ORDER BY
    count_ ASC

