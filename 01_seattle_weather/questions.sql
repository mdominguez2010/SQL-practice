--\connect ex_seattle_weather;

--1. Select all rows from December 1st, 2000 to December 15th, 2000 (inclusive)

-- SELECT *
-- FROM weather
-- WHERE date_weather BETWEEN '2000-12-01 00:00:00' AND '2000-12-15 00:00:00';

--2. Get the average maximum temperature for every year from the 2000 onward.
--Order the results by year

-- SELECT EXTRACT('year' FROM date_weather) AS year, AVG(temp_max) AS avg_high_temp

-- FROM (SELECT * FROM weather WHERE EXTRACT('year' FROM date_weather) >= 2000) AS filtered_table

-- GROUP BY year
-- ORDER BY year ASC;

--3. Get the standard deviation of the maximum temperature per year, from 2000 onward.
--Order by year (ascending)

-- SELECT EXTRACT('year' FROM date_weather) AS year, STDDEV(temp_max) AS std_dev_temp_max
-- FROM (SELECT * FROM weather WHERE EXTRACT('year' FROM date_weather) >= 2000) AS filtered_table
-- GROUP BY year
-- ORDER BY year ASC;

--4. What are the 10 hottest days on record? Take the hottest to mean 'highest maximum temperature'

-- SELECT date_weather
-- FROM weather
-- ORDER BY temp_max DESC
-- LIMIT 10;

--5. In 2016, what fraction of days did it rain

-- WITH reference_table AS(
-- SELECT *,
--     CASE
--         WHEN did_rain = 't' THEN 1
--         ELSE 0
--     END AS rain,
--     CASE
--         WHEN did_rain = 'f' THEN 1
--         ELSE 0
--     END AS no_rain
-- FROM (SELECT * FROM weather WHERE EXTRACT('year' FROM date_weather) = 2016) AS filtered_table
-- )

-- SELECT SUM(rain) AS rainy, SUM(rain) + SUM(no_rain) AS total_days, SUM(CAST(rain AS decimal)) / (SUM(CAST(rain AS decimal)) + SUM(CAST(no_rain as decimal))) AS fraction_rainy_days
-- FROM reference_table;

--6. What is the 75th percentile for the amount of rain that fell on a day where there was
-- some rain in 2016?

-- WITH reference_table AS(
-- SELECT *
-- FROM (SELECT * FROM weather WHERE EXTRACT('year' FROM date_weather) = 2016) AS filtered_table
-- WHERE did_rain = 't'
-- )

-- SELECT 
--     PERCENTILE_DISC(0.75) WITHIN GROUP(ORDER BY inches_rain)
-- FROM reference_table;

--7. What is the 75th percentile for the amount of rain that fell on any day in 2016?

-- WITH reference_table AS(
-- SELECT *
-- FROM (SELECT * FROM weather WHERE EXTRACT('year' FROM date_weather) = 2016) AS filtered_table
-- )

-- SELECT 
--     PERCENTILE_DISC(0.75) WITHIN GROUP(ORDER BY inches_rain)
-- FROM reference_table;

--8. Get the 10 years with the hottest average maximum temperature in July
--Order from hottest to coolest

-- SELECT 
--     EXTRACT('year' FROM date_weather) AS year,
--     AVG(temp_max) AS avg_july_high_temp
-- FROM weather
-- WHERE EXTRACT('month' FROM date_weather) = 7
-- GROUP BY year
-- ORDER BY AVG(temp_max) DESC
-- LIMIT 10;

--9. Get the 10 years with the coldest average minimum temperature in December
--Order from coolest to hottest

-- SELECT 
--     EXTRACT('year' FROM date_weather) AS year,
--     AVG(temp_min) AS avg_july_low_temp
-- FROM weather
-- WHERE EXTRACT('month' FROM date_weather) = 12
-- GROUP BY year
-- ORDER BY AVG(temp_min)
-- LIMIT 10;

--10. Repeat the last question, but round the temperatures to 3 decimal places

-- SELECT 
--     EXTRACT('year' FROM date_weather) AS year,
--     ROUND(AVG(temp_min::numeric), 3) AS avg_july_low_temp
-- FROM weather
-- WHERE EXTRACT('month' FROM date_weather) = 12
-- GROUP BY year
-- ORDER BY AVG(temp_min)
-- LIMIT 10;

--11. Given the results of the previous queries, would it be fair to use this data to claim
--that 2015 had the "hottest July on record"? Why or why not?
--ANSWER: No, because the query calculates the highest average (in descending order), not max of the entire table

--12. Give the average inches of rain that fell per day for each month,
--where the average is taken over 2000-2010 (inclusive)

SELECT 
    EXTRACT('month' FROM date_weather) AS month,
    ROUND(AVG(inches_rain::numeric), 3) AS avg_inches_rain
FROM weather
WHERE EXTRACT('year' FROM date_weather) BETWEEN 2000 AND 2010
GROUP BY month;