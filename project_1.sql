create database Employee;
use Employee;
select * from emp_record_table;
select * from data_science_team;
select * from proj_table;


-- 2. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and
--    DEPARTMENT from the employee record table, and make a list of employees
--    and details of their department.

select emp_id, first_name, last_name, gender, dept from emp_record_table;

-- 3. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER,
--     DEPARTMENT, and EMP_RATING if the EMP_RATING is:
-- ● less than two
-- ● greater than four
-- ● between two and four
select emp_id, first_name, last_name, gender, dept,emp_rating from emp_record_table
 where emp_rating<2;
select emp_id, first_name, last_name, gender, dept,emp_rating from emp_record_table
where emp_rating>4;
select emp_id, first_name, last_name, gender, dept,emp_rating from emp_record_table
where emp_rating between 2 and 4;

-- 4.Write a query to concatenate the FIRST_NAME and the LAST_NAME of
--   employees in the Finance department from the employee table and then give
--   the resultant column alias as NAME.
SELECT CONCAT(FIRST_NAME,' ' ,LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'FINANCE';

-- 5. Write a SQL query to retrieve the employee ID, first name, role, and
--    department of employees who hold leadership positions (Manager,
 --   President, or CEO).
select emp_id, first_name, role, dept from emp_record_table
where role like 'manager';

-- 6. Write a query to list all the employees from the healthcare and finance
--    departments using the union. Take data from the employee record table

select * from emp_record_table where DEPT = 'healthcare' 
union
select * from emp_record_table where dept = 'finance';

-- 7.Write a query to list employee details such as EMP_ID, FIRST_NAME,
--   LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also
--   include the respective employee rating along with the max emp rating for the department.

select emp_id,first_name,last_name,role,dept,emp_rating,
max(emp_rating) over (partition by dept) as max_dept_rating
from emp_record_table;


-- 8.Write a query to calculate the minimum and the maximum salary of the
--   employees in each role. Take data from the employee record table.
select Role, max(salary) as Max_Salary,
min(salary) as Min_Salary FROM emp_record_table
group by Role;

-- 9.Write a query to assign ranks to each employee based on their experience.
--   Take data from the employee record table
select emp_id, first_name, last_name, exp,dense_rank()
over (order by exp desc) as exp_rank
from emp_record_table;

-- 10.Write a query to create a view that displays employees in various countries
--    whose salary is more than six thousand. Take data from the employee record
--    table.

create view high_salary as
select emp_id,first_name,last_name,country,salary
from emp_record_table 
where salary > 6000;
select * from high_salary;

-- 11.Write a nested query to find employees with experience of more than ten
--    years.Take data from the employee record table
select * from emp_record_table
where emp_id in ( select emp_id from emp_record_table
                 where exp > 10);


-- 12.Write a query using stored functions in the project table to check whether
--    the job profile assigned to each employee in the data science team matches
--    the organization’s set standard.
--    The standard being:
--    For an employee with experience less than or equal to 2 years assign 'JUNIOR
--    DATA SCIENTIST',
--    For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA
--    SCIENTIST',
--    For an employee with the experience of 5 to 10 years assign 'SENIOR DATA
--    SCIENTIST',
--    For an employee with the experience of 10 to 12 years assign 'LEAD DATA
--    SCIENTIST',
--    For an employee with the experience of 12 to 16 years assign 'MANAGER'.

-- 1. creating the stored function

DELIMITER $$

CREATE FUNCTION get_standard_job_role(exp INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE job_role VARCHAR(50);

    IF exp <= 2 THEN
        SET job_role = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp > 2 AND exp <= 5 THEN
        SET job_role = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp > 5 AND exp <= 10 THEN
        SET job_role = 'SENIOR DATA SCIENTIST';
    ELSEIF exp > 10 AND exp <= 12 THEN
        SET job_role = 'LEAD DATA SCIENTIST';
    ELSEIF exp > 12 AND exp <= 16 THEN
        SET job_role = 'MANAGER';
    ELSE
        SET job_role = 'NOT DEFINED';
    END IF;

    RETURN job_role;
END $$ 

-- 2. Using the Function to Validate Job Profiles

SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    EXP,
    ROLE AS ASSIGNED_ROLE,
    get_standard_job_role(EXP) AS STANDARD_ROLE,
    CASE
        WHEN ROLE = get_standard_job_role(EXP) THEN 'MATCHED'
        ELSE 'NOT MATCHED'
    END AS PROFILE_STATUS
FROM data_science_team;



-- 13.Create an index to improve the cost and performance of the query to find
--    the employee whose FIRST_NAME is ‘Eric’ in the employee table after
--    checking the execution plan.

-- 1.Checking Execution Plan (Before Index) 

SELECT *FROM emp_record_table
WHERE FIRST_NAME = 'Eric';

-- 2. Create Index on FIRST_NAME

CREATE INDEX idx_first_name
ON emp_record_table (FIRST_NAME);

-- 3.Checking Execution Plan (After Index)

SELECT *FROM emp_record_table
WHERE FIRST_NAME = 'Eric';

-- 14.Write a query to calculate the bonus for all the employees, based on their
--    ratings and salaries (Use the formula: 5% of salary * employee rating).
select emp_id,first_name,last_name,salary,emp_rating,(salary * 0.05 * emp_rating) as bonus
from emp_record_table;

-- 15.Write a query to calculate the average salary distribution based on the
--    continent and country. Take data from the employee record table.

select continent,country, avg(salary) as avg_salary
FROM emp_record_table
group by continent,country;


