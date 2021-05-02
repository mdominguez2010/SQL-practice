-- Write a 7-day rolling (preceding) average of daily sign-ups

--using window function
SELECT
    AVG(sign_ups) OVER(ORDER BY date
        ROWS BETWEEN 6 PRECEEDING AND CURRENT ROW) as 7_day_roll_avg
FROM signups;

--using join
FROM
    signups a
JOIN
    signups b ON a.date <= b.date + interval '6 days'
    AND a.date >= b.date
GROUP BY
    a.date;