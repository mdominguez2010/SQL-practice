-- running totals problem
SELECT
    date,
    SUM(cash_flow) OVER(ORDER BY date ASC) AS cumulative_cf
FROM transactions
ORDER BY date ASC;