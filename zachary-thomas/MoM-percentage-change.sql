/*
https://quip.com/2gwZArKuWk7W
*/

WITH mau AS
(
    SELECT
    TRUNC(date, 'month') AS month,
    COUNT(DISTINCT user_id) as monthly_active_users
FROM logins
GROUP BY TRUNC(date, 'month')
)

SELECT
    a.month AS previous_month,
    a.mau AS previous_monthly_active_users,
    b.month AS current_month,
    b.month AS current_monthly_active_users,
    ROUND(100 * (current_monthly_active_users - previous_monthly_active_users) / previous_monthly_active_users)
        AS percent_change
FROM mau a
    JOIN
        mau b ON a.month = b.month - interval '1 month';