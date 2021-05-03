-- 1. How many users are there in each house?
-- SELECT
--     house,
--     COUNT(user_id)
-- FROM users
-- GROUP BY house;

-- 2. List all following links that were created before September 1st, 1993

-- SELECT
--     *
-- FROM
--     follows
-- WHERE DATE(date_created) < '1993-09-01';

--3. List all rows from the follows table, replacing both user_ids with first name.
--Hint: it may help to make this a VIEW
--  user_id | follows |    date_created      user_id | first_name | last_name |   house     user_id | first_name | last_name |   house 
-- ---------+---------+------------------------------+------------+-----------+---------------------+------------+-----------+------------
--        1 |       2 | 1993-09-01 00:00:00         1 | Harry      | Potter    | Gryffindor       2 | Ron        | Wesley    | Gryffindor
--        2 |       1 | 1989-01-01 00:00:00         2 | Ron        | Wesley    | Gryffindor
--        3 |       1 | 1993-07-01 00:00:00
--        2 |       3 | 1994-10-10 00:00:00
--        3 |       2 | 1995-03-01 00:00:00
--        4 |       2 | 1988-08-08 00:00:00
--        4 |       1 | 1988-08-08 00:00:00
--        1 |       4 | 1994-04-02 00:00:00
--        1 |       5 | 2000-01-01 00:00:00
--        5 |       1 | 2000-01-02 00:00:00
--        5 |       6 | 1986-01-10 00:00:00
--        7 |       1 | 1990-02-02 00:00:00
--        1 |       7 | 1996-10-01 00:00:00
--        1 |       8 | 1993-09-03 00:00:00
--        8 |       1 | 1995-09-01 00:00:00
--        8 |       9 | 1995-09-01 00:00:00
--        9 |       8 | 1996-01-10 00:00:00
--        7 |       8 | 1993-09-01 00:00:00
--        3 |       9 | 1996-05-30 00:00:00
--        4 |       9 | 1996-05-30 00:00:00

-- SELECT
--     s.first_name AS user_first,
--     s1.first_name AS follow_first,
--     f.date_created
-- FROM
--     users s
--         INNER JOIN follows f
--             ON s.user_id = f.user_id
--         INNER JOIN users s1
--             ON s1.user_id = f.follows;

-- 4. List all the following links established before September 1st 1993,
-- but this time use the users first names.

-- SELECT
--     s.first_name AS user_first,
--     s1.first_name AS follow_first,
--     f.date_created
-- FROM
--     users s
--         INNER JOIN follows f
--             ON s.user_id = f.user_id
--         INNER JOIN users s1
--             ON s1.user_id = f.follows
-- WHERE DATE(f.date_created) < '1993-09-01';

-- 5. Give a count of how many people followed each user as of 1999-12-31.
-- Give the result in term of "users full name, number of followers".

SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS user_followed_name,
    COUNT(s1.first_name)
    -- s1.first_name AS follow_first,
    -- f.date_created
    -- s.*,
    -- f.*,
    -- s1.*
FROM
    users s
        INNER JOIN follows f
            ON s.user_id = f.user_id
        INNER JOIN users s1
            ON s1.user_id = f.follows
WHERE DATE(f.date_created) <= '1999-12-31'
GROUP BY CONCAT(s.first_name, ' ', s.last_name);

UNSURE ABOUT THIS ONE. I'LL COME BACK TO IT!