CREATE TABLE departments (
  dept_no VARCHAR,
	dept_name VARCHAR,
 PRIMARY KEY(dept_no));
*************************************
CREATE TABLE dep_emp (emp_no int,
					  dept_no VARCHAR,
   FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments(dept_no));
***************************************  
CREATE TABLE dep_manager (dept_no VARCHAR,
						  emp_no int,
  FOREIGN KEY (dept_no)  REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no)  REFERENCES employees(emp_no))
******************************************
CREATE TABLE employees(emp_no int PRIMARY KEY,
					   emp_title_id VARCHAR,
					   birth_date date,	
					   first_name VARCHAR,
					   last_name VARCHAR,	
					   sex	VARCHAR,
					   hire_date date)
**********************************************
CREATE TABLE salaries(emp_no int,
					  salary int,
					  PRIMARY KEY (emp_no))
					--FOREIGN KEY (emp_no)  REFERENCES employees(emp_no)
					 
**********************************************
CREATE TABLE titles(title_id VARCHAR,
					title VARCHAR,
					PRIMARY KEY (title_id))--,
				--FOREIGN KEY (title_id) REFERENCES employees(emp_title_id))
   select * from dep_emp
************************************************
--1.) List the following details of each employee: employee number,
												--last name, 
												--first name, 
												--sex, 
												--and salary.
SELECT  e.emp_no, 
		e.last_name, 
		e.first_name, 
		e.sex, 
		s.salary
FROM employees e, 
	 salaries s 
WHERE s.emp_no = e.emp_no

***************************************************************
2.-- List first name, last name, and hire date 
--for employees who were hired in 1986.
SELECT distinct e.first_name,
				e.last_name,
				e.hire_date
FROM employees e
WHERE e.hire_date between '01/01/1986' and '12/31/1986'
ORDER BY e.hire_date

**************************************************************
--3. List the manager of each department with the following information: 
--department number, 
--department name, 
--the manager's employee number, 
--last name, 
--first name.
SELECT  d.dept_no, 
		d.dept_name, 
		dm.emp_no,
		e.last_name,
		e.first_name
FROM employees e, departments d, dep_manager dm
WHERE dm.dept_no = d.dept_no
and   dm.emp_no = e.emp_no
*****************************************************
--4.)List the department of each employee with the following information: 
--employee number,
--last name, 
--first name,
--and department name.
SELECT distinct e.emp_no,
				e.last_name,
				e.first_name,
				d.dept_name
FROM  employees e, departments d, dep_emp de
WHERE de.emp_no = e.emp_no
and de.dept_no = d.dept_no
*******************************************************
----5. List first name, 
--			last name, 
--			and sex 
--			for employees whose first name is "Hercules" and last names begin with "B."
SELECT distinct e.first_name,
		e.last_name,
		e.sex
FROM employees e
WHERE e.first_name = 'Hercules'
and   e.last_name like 'B%'
********************************************************
--6. List all employees in the Sales department, 
--including their employee number, 
--last name, 
--first name, 
--and department name.
SELECT  e.emp_no, 
		e.last_name,
		e.first_name,
		d.dept_name
FROM  employees e, departments d, dep_emp de
WHERE de.emp_no = e.emp_no
and de.dept_no = d.dept_no
and d.dept_name = 'Sales'
**************************************************************
--7. List all employees in the Sales and Development departments
SELECT  e.emp_no, 
		e.last_name,
		e.first_name,
		d.dept_name
FROM  employees e, departments d, dep_emp de
WHERE de.emp_no = e.emp_no
and de.dept_no = d.dept_no
and d.dept_name in ('Sales', 'Development')
*******************************************************************
--8. In descending order, list the frequency count of employee last names,
--i.e., how many employees share each last name.
SELECT distinct e.last_name, 
				count(distinct e.emp_no)
FROM employees e
GROUP BY e.last_name
ORDER BY count(distinct e.emp_no) DESC