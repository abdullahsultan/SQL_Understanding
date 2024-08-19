use employees_mod;
select * from t_employees;

SELECT
    YEAR(t_dept_manager.from_date) AS calendar_year, 
    gender,
    COUNT(t_employees.emp_no) AS num_of_employees
FROM t_employees
JOIN t_dept_manager ON t_employees.emp_no = t_employees.emp_no
GROUP BY calendar_year, gender 
HAVING calendar_year >= 1990 ORDER BY calendar_year
;

-- Ex 324
SELECT 
    t_employees.gender,
    t_departments.dept_name,
    ROUND(AVG(t_salaries.salary),2) AS salary,
    YEAR(t_salaries.from_date) AS calendar_year
FROM
    t_salaries
    JOIN t_employees ON t_salaries.emp_no = t_employees.emp_no
    JOIN t_dept_emp ON t_dept_emp.emp_no = t_employees.emp_no
    JOIN t_departments ON t_departments.dept_no = t_dept_emp.dept_no
GROUP BY 
    t_departments.dept_no ,gender, calendar_year
HAVING
    calendar_year <= 2002    
ORDER BY 
    t_dept_emp.dept_no;


-- Ex 327
DROP PROCEDURE IF EXISTS filter_salary;
DELIMITER $$
CREATE PROCEDURE filter_salary(IN min_salary FLOAT, IN max_salary FLOAT)
BEGIN
SELECT 
    t_employees.gender,
    t_departments.dept_name,
    AVG(t_salaries.salary) AS avg_salary
FROM
    t_employees

   JOIN t_salaries ON t_salaries.emp_no = t_employees.emp_no
   JOIN t_dept_emp ON t_dept_emp.emp_no = t_employees.emp_no
   JOIN t_departments ON t_departments.dept_no = t_dept_emp.dept_no
   WHERE t_salaries.salary BETWEEN min_salary AND max_salary
GROUP BY gender, dept_name
;
END$$
DELIMITER ;
CALL filter_salary(50000, 90000);








