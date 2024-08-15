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

SELECT 
YEAR(t_dept_emp.from_date) AS calendar_year,
t_employees.emp_no,
t_dept_emp.dept_no,
t_dept_emp.from_date,
t_dept_emp.to_date,
t_departments.dept_name,
t_employees.birth_date,
t_employees.first_name,
t_employees.last_name,
t_employees.gender,
t_employees.hire_date
FROM
	t_employees
JOIN
	t_dept_emp ON t_employees.emp_no = t_dept_emp.emp_no
JOIN
	t_departments ON t_departments.dept_no = t_dept_emp.dept_no
ORDER BY calendar_year, t_employees.emp_no;



