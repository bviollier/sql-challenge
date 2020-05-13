-- DROP TABLES

Drop Table departments;
Drop Table dept_emp;
Drop Table dept_manager;
Drop Table employees;
Drop Table salaries;
Drop Table titles;

-- CREATE TABLES

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" Date   NOT NULL,
    "to_date" Date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" Date   NOT NULL,
    "to_date" Date   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" Date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" Date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" Date   NOT NULL,
    "to_date" Date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" Date   NOT NULL,
    "to_date" Date   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- CHECK TABLES

Select * from departments;
Select * from dept_emp;
Select * from dept_manager;
Select * from employees;
Select * from salaries;
Select * from titles;

-- 1. Each employee

Select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
JOIN salaries AS s 
ON e.emp_no = s.emp_no
ORDER BY emp_no;

-- 2. Employees hired in 1986

SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. Manager of each department

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM departments AS d
JOIN dept_manager AS dm ON
d.dept_no = dm.dept_no
JOIN employees AS e ON
e.emp_no = dm.emp_no;

-- 4. Department of each employee

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments AS d
JOIN dept_emp AS de ON
d.dept_no = de.dept_no
JOIN employees AS e ON
de.emp_no = e.emp_no;

-- 5. Employees whose first name is "Hercules" and last name begins with "B"

SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- 6. Employees from Sales department

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments AS d
JOIN dept_emp AS de ON
d.dept_no = de.dept_no
JOIN employees AS e ON
de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales';

-- 7. Employees from Sales and Development departments

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments AS d
JOIN dept_emp AS de ON
d.dept_no = de.dept_no
JOIN employees AS e ON
de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- 8. Frequency of shared employee last names

SELECT COUNT(last_name), last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

-- Update employee ID

SELECT * FROM employees
WHERE emp_no = 499942;

UPDATE employees
SET first_name = 'Benoit',
	last_name = 'Viollier',
	gender = 'M'
WHERE emp_no = 499942;

