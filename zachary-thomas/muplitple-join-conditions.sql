--Say we habe a table 'emails' that include emails to and from 'zach@g.com'

-- | id | subject  | from         | to           | timestamp           | id | subject  | from         | to           | timestamp           |
-- |----|----------|--------------|--------------|---------------------|
-- | 1  | Yosemite | zach@g.com   | thomas@g.com | 2018-01-02 12:45:03 |
-- | 2  | Big Sur  | sarah@g.com  | thomas@g.com | 2018-01-02 16:30:01 |
-- | 3  | Yosemite | thomas@g.com | zach@g.com   | 2018-01-02 16:35:04 | 5  | Yosemite | zach@g.com   | thomas@g.com | 2018-01-03 14:02:01 |
-- | 4  | Running  | jill@g.com   | zach@g.com   | 2018-01-03 08:12:45 |
-- | 5  | Yosemite | zach@g.com   | thomas@g.com | 2018-01-03 14:02:01 | 6  | Yosemite | thomas@g.com | zach@g.com   | 2018-01-03 15:01:05 |
-- | 6  | Yosemite | thomas@g.com | zach@g.com   | 2018-01-03 15:01:05 |
-- | .. | ..       | ..           | ..           | ..                  |

--Task: write a query to get the response time per email (id) sent to 'zach@g.com'.
--Do not include ids that did not receive a repsonse from zach. Assume each email thread
--has a unique subject. Keep in mind a thread may have multiple responses back-and-forth
--between zach and another email address

--Do not include threads with only one email sent to zach
--each email thread has a unique subject
--threads are identified by same subject
--calculate average response time
SELECT
    b.id,
    MIN(b.timestamp) - a.timestamp AS time_to_respond
FROM emails a
    JOIN emails b
        ON b.subject = a.subject
        AND a.to = b.from
        AND a.from = b.to
        AND a.timestamp < b.timestamp
    WHERE b.from = 'zach@g.com'
GROUP BY b.id;
