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
