
CREATE TABLE departments
(
	dept_no VARCHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(30) NOT NULL
);

CREATE TABLE dept_emp
(
	emp_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

CREATE TABLE dept_manager
(
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

CREATE TABLE employee
(
	emp_no VARCHAR(10) PRIMARY KEY NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(1) NOT NULL,
	hire_date VARCHAR(30) NOT NULL
);

CREATE TABLE salaries
(
	emp_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

CREATE TABLE titles
(
	emp_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR(30) NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);
---List the following details of each employee: employee number, last name, first name, gender, and salary.


SELECT employee.emp_no, 
employee.first_name, employee.last_name,
employee.gender, salaries.salary
FROM salaries
INNER JOIN employee ON
employee.emp_no=salaries.emp_no */

--List employees who were hired in 1986.
SELECT * FROM employee
WHERE hire_date LIKE '1986%';

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, 
--and start and end employment dates.
SELECT departments.dept_no, departments.dept_name, 
dept_manager.emp_no, employee.last_name, employee.first_name, 
dept_manager.from_date, dept_manager.to_date
FROM departments 
INNER JOIN dept_manager ON
dept_manager.dept_no = departments.dept_no
JOIN employee ON
employee.emp_no = dept_manager.emp_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employee AS e
INNER JOIN dept_emp AS de ON
e.emp_no = de.emp_no
INNER JOIN departments AS d ON
d.dept_no = de.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employee
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%';


--List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT emp_no, first_name, last_name
FROM employee
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN(
		SELECT dept_no
		FROM departments 
		WHERE dept_name = 'Sales'
		)
	);
	

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT emp_no, first_name, last_name
FROM employee
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN(
		SELECT dept_no
		FROM departments 
		WHERE dept_name = 'Sales'
		or dept_name = 'Development'
		)
	);
	
--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name, COUNT(*) AS frequency
FROM employee
GROUP BY last_name
ORDER BY frequency DESC;
