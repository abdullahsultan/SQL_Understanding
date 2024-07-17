CREATE OR REPLACE VIEW v_avg_salary AS SELECT AVG(salary) FROM salaries WHERE EXISTS (SELECT emp_no FROM dept_manager WHERE dept_manager.emp_no = salaries.emp_no);

SELECT * FROM v_avg_salary;