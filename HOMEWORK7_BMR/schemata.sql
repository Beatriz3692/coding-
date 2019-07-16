
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
