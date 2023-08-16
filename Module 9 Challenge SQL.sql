--create table TITLES with pk title-id 
CREATE TABLE TITLES (
    title_id VARCHAR(10) NOT NULL,
    title VARCHAR(20)   NOT NULL,
  CONSTRAINT pk_titles PRIMARY KEY (title_id)
);	
--create tables EMPLOYEES with primary key emp_no
CREATE TABLE EMPLOYEES (
emp_no VARCHAR(20),
emp_title_id VARCHAR(20),
birth_date DATE,
first_name VARCHAR(40),
last_name VARCHAR(40),
sex VARCHAR(4),
hire_date DATE,
PRIMARY KEY (emp_no)
);

--create table DEPARTMENTS with pk dept_no
CREATE TABLE DEPARTMENTS (
dept_no VARCHAR(10), 
dept_name VARCHAR(20),
PRIMARY KEY (dept_no)	
);
--create table DEPT-EMP with fks to emp_no, dept_no
CREATE TABLE DEPT_EMP (
    emp_no VARCHAR(20) NOT NULL,
    dept_no VARCHAR(10) NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES EMPLOYEES (emp_no),
 FOREIGN KEY (dept_no) REFERENCES DEPARTMENTS(dept_no)
);
--create table DEPT_MANAGER with fks to emp_no, dept_no
CREATE TABLE DEPT_MANAGER (
    dept_no VARCHAR(10) NOT NULL,
    emp_no VARCHAR(20)   NOT NULL,
 FOREIGN KEY (dept_no) REFERENCES DEPARTMENTS(dept_no),
 FOREIGN KEY (emp_no) REFERENCES EMPLOYEES (emp_no)	
);
--create table SALARIES with fk to emp_no
CREATE TABLE SALARIES (
    emp_no VARCHAR(20) NOT NULL,
    salary INT NOT NULL,
FOREIGN KEY (emp_no) REFERENCES EMPLOYEES(emp_no)	
);

SELECT * from SALARIES
limit(10);

SELECT * from EMPLOYEES
limit(10);

--List the employee number, last name, first name, sex and salary of each employee
SELECT EMPLOYEES.emp_no, 
EMPLOYEES.last_name,
EMPLOYEES.first_name,
EMPLOYEES.sex,
SALARIES.salary
FROM EMPLOYEES
LEFT JOIN SALARIES
ON EMPLOYEES.emp_no = SALARIES.emp_no
ORDER BY emp_no
limit(10);

--list first, last name and hire date for employees hired in 1986
SELECT EMPLOYEES.first_name,
EMPLOYEES.last_name,
EMPLOYEES.hire_date
FROM EMPLOYEES
WHERE DATE_PART('year',hire_date) = 1986

--List the manager of each department along with: 
--department number, department name, employee number, 
--last name, first name
SELECT DEPT_MANAGER.dept_no, 
DEPARTMENTS.dept_name,
DEPT_MANAGER.emp_no,
EMPLOYEES.last_name, 
EMPLOYEES.first_name
FROM DEPT_MANAGER
LEFT JOIN DEPARTMENTS
ON DEPT_MANAGER.dept_no = DEPARTMENTS.dept_no
LEFT JOIN EMPLOYEES
ON DEPT_MANAGER.emp_no = EMPLOYEES.emp_no

--List the department for each employee along with: 
--employee number, last name, first name, and department name.
SELECT
EMPLOYEES.emp_no,
EMPLOYEES.last_name,
EMPLOYEES.first_name,
DEPT_EMP.dept_no,
DEPARTMENTS.dept_name
FROM EMPLOYEES 
INNER JOIN DEPT_EMP ON EMPLOYEES.emp_no=DEPT_EMP.emp_no
INNER JOIN DEPARTMENTS ON DEPARTMENTS.dept_no=DEPT_EMP.dept_no

--List first, last name and sex of each employee whose first name is "Hercules"
--and last names begin with the letter B.
SELECT 
EMPLOYEES.first_name,
EMPLOYEES.last_name,
EMPLOYEES.sex
FROM EMPLOYEES
WHERE first_name = 'Hercules' AND last_name like 'B%';

--List each employee in the Sales department, including their
-- employee number, last name, first name.
SELECT 
EMPLOYEES.emp_no, 
EMPLOYEES.last_name, 
EMPLOYEES.first_name,
DEPT_EMP.dept_no
FROM EMPLOYEES
LEFT JOIN DEPT_EMP 
ON EMPLOYEES.emp_no=DEPT_EMP.emp_no
LEFT JOIN DEPARTMENTS 
ON DEPARTMENTS.dept_no=DEPT_EMP.dept_no
WHERE DEPARTMENTS.dept_name='Sales';

-- List every employee in the Sales and Development departments, including 
--employee number, last name, first name, and department name.
SELECT 
EMPLOYEES.emp_no, 
EMPLOYEES.last_name, 
EMPLOYEES.first_name,
DEPT_EMP.dept_no
FROM EMPLOYEES 
LEFT JOIN DEPT_EMP 
ON EMPLOYEES.emp_no=DEPT_EMP.emp_no
INNER JOIN DEPARTMENTS 
ON DEPARTMENTS.dept_no=DEPT_EMP.dept_no
WHERE DEPARTMENTS.dept_name in ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names 
--(how many employees share each last name).
SELECT last_name, COUNT(*) AS freq_count
FROM EMPLOYEES
GROUP BY last_name
ORDER BY freq_count DESC;
