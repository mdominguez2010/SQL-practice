-- 1. **List all the employees in order of descreasing salary**

-- SELECT
--     name
-- FROM employee
-- ORDER BY salary DESC;

-- 2. **List all the department names, and the number of employees in that department.
-- Order by number of employess in department (greatest to least)**

--join tables
--Select department name
--count number employees in each department (empid)
--group by empid
--order by empployees desc

-- SELECT d.deptname, COUNT(empid) AS n_employees
-- FROM employee e
--     RIGHT JOIN department d
--         ON e.deptid = d.deptid
-- GROUP BY d.deptname
-- ORDER BY COUNT(empid) DESC;

-- 3. **List all the employees that don't have a manager**

--assumptions: employees with null in managerid column == employee has no manager
--select all columns (*)
--form employee table
--where managerid is null

-- SELECT
--     *
-- FROM employee
-- WHERE managerid IS NULL;

-- 4. **List all employees by name, and the name of their manager.
-- If the employee doesn't have a manager, leave the column as NULL.**

--self join
--select e.name, m.name
--no filters

-- SELECT
--     e.name employee,
--     m.name manager
-- FROM employee e LEFT JOIN employee m
-- ON e.managerid = m.empid;

-- 5. **For each manager, list the number of employees he or she is managing.
-- For these purposes, a manager is anyone who is not managed by someone else, even if that person has no direct reports.**

--manager == an employee with a NULL in managerid column

--COME BACK TO THIS ONE

--6. **Find the two highest paid people per department**

SELECT
    ranked_table.*
FROM(
    SELECT
        e.name, e.deptid, e.salary,
        DENSE_RANK() OVER(PARTITION BY e.deptid ORDER BY e.salary) AS salary_rank
        FROM employee e
    ) AS ranked_table
WHERE salary_rank BETWEEN 1 AND 2;
