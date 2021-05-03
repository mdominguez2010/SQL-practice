-- #1: Get the ID with the highest value
--salaries table
  depname  | empno | salary | salary_rank |     
-----------+-------+--------+--------+
 develop   |    11 |   5200 | 5
 develop   |     7 |   4200 | 8
 develop   |     9 |   4500 | 9
 develop   |     8 |   6000 | 10
 develop   |    10 |   5200 | 11
 personnel |     5 |   3500 | 5
 personnel |     2 |   3900 | 1
 sales     |     3 |   4800 | 2
 sales     |     1 |   5000 | 3
 sales     |     4 |   4800 | 3
 --write a query get the empno with the highest salary. make sure your solution can
 --handle ties
 --assumptions:
    --empno is primary key
    --there are employees with the same salary

WITH salary_rank AS
    (SELECT
        empno,
        DENSE_RANK() OVER(ORDER BY salary) AS sal_rank
    FROM
        salary)

SELECT
    empno
FROM salary_rank
WHERE sal_rank = 1;

-- #2: Average and rank with a window function (multi-part)
--salaries table
  depname  | empno | salary |     
-----------+-------+--------+
 develop   |    11 |   5200 | 
 develop   |     7 |   4200 | 
 develop   |     9 |   4500 | 
 develop   |     8 |   6000 | 
 develop   |    10 |   5200 | 
 personnel |     5 |   3500 | 
 personnel |     2 |   3900 | 
 sales     |     3 |   4800 | 
 sales     |     1 |   5000 | 
 sales     |     4 |   4800 | 
--task: write a query that returns the same table, but with a new column
-- that has an average salary per depname. We would expect a table
-- in the following form:
  depname  | empno | salary | avg_salary |     
-----------+-------+--------+------------+
 develop   |    11 |   5200 |       5020 |
 develop   |     7 |   4200 |       5020 | 
 develop   |     9 |   4500 |       5020 |
 develop   |     8 |   6000 |       5020 | 
 develop   |    10 |   5200 |       5020 | 
 personnel |     5 |   3500 |       3700 |
 personnel |     2 |   3900 |       3700 |
 sales     |     3 |   4800 |       4867 | 
 sales     |     1 |   5000 |       4867 | 
 sales     |     4 |   4800 |       4867 |

 SELECT
    *
    ROUND(AVG(salary), 0) OVER(PARTITION BY depname) AS avg_salary
FROM
    salaries;

--part 2: write a query that adds a column with the rank of each employee
--based on their salary within their department, where the employee with
--the highest salary gets the rank of 1. We would expect the following table:
  depname  | empno | salary | salary_rank |     
-----------+-------+--------+-------------+
 develop   |    11 |   5200 |           2 |
 develop   |     7 |   4200 |           5 | 
 develop   |     9 |   4500 |           4 |
 develop   |     8 |   6000 |           1 | 
 develop   |    10 |   5200 |           2 | 
 personnel |     5 |   3500 |           2 |
 personnel |     2 |   3900 |           1 |
 sales     |     3 |   4800 |           2 | 
 sales     |     1 |   5000 |           1 | 
 sales     |     4 |   4800 |           2 | 

 SELECT
    *,
    DENSE_RANK() OVER(PARTITION BY depname ORDER BY salary) AS salary_rank
FROM
    salaries