USE employees;

SELECT first_name, last_name FROM employees;

# SELECT 
SELECT dept_no FROM departments;
SELECT * FROM departments;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';

#AND OR    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' OR first_name = 'Elvis';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND (gender = 'M' OR gender = 'F');
    
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');
    
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Cathie'
        OR first_name = 'Mark'
        OR first_name = 'Nathan';
        
#IN NOT IN
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'Mark', 'Nathan');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis', 'Elvis');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John', 'Mark' , 'Jacob');
    

# LIKE
SELECT * FROM employees WHERE first_name LIKE ('Mar%');
SELECT * FROM employees WHERE first_name LIKE ('ar%');
SELECT * FROM employees WHERE first_name LIKE ('%ar%');
SELECT * FROM employees WHERE first_name LIKE ('Mar_');
SELECT * FROM employees WHERE first_name NOT LIKE ('%mar%');

SELECT * FROM employees WHERE first_name LIKE ('Mark%');
SELECT * FROM employees WHERE YEAR(hire_date) LIKE (2000);
SELECT * FROM employees WHERE hire_date LIKE ('%2000%');
SELECT * FROM employees WHERE emp_no LIKE('1000_');

SELECT * FROM employees WHERE first_name LIKE ('%Jack%');
SELECT * FROM employees WHERE first_name NOT LIKE ('%Jack%');

# BETWEEN
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';
SELECT * FROM employees WHERE hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * FROM salaries WHERE salary BETWEEN 66000 AND 70000;
SELECT * FROM employees WHERE emp_no NOT BETWEEN 10004 AND 10012;

SELECT * FROM departments WHERE dept_no BETWEEN 'd003' AND 'd006';

# IS NOT NULL
SELECT dept_name FROM departments WHERE dept_no IS NOT NULL;

# Other comparisson operators

SELECT * FROM employees WHERE hire_date > '2000-01-01';
SELECT * FROM employees WHERE hire_date < '1985-02-01';

SELECT * FROM employees WHERE YEAR(hire_date) >= 2000 AND gender = 'F';
SELECT * FROM salaries WHERE salary > 150000;

SELECT DISTINCT hire_date FROM employees;

#COUNT()
SELECT COUNT(emp_no) FROM employees;
SELECT COUNT(DISTINCT first_name) FROM employees;
# count how many salaries greater than 100000
SELECT COUNT(*) FROM salaries WHERE salary >= 100000;
SELECT COUNT(*) FROM dept_manager;

# ORDER BY
SELECT * FROM employees ORDER BY first_name DESC;
SELECT * FROM employees ORDER BY emp_no DESC;
SELECT * FROM employees ORDER BY first_name, last_name;

SELECT * FROM employees ORDER BY hire_date DESC;

#GROUP BY
SELECT first_name FROM employees GROUP BY first_name; 
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY first_name; #counts how many time each name has appeared

# Using aliases
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name; #counts how many time each name has appeared

SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

# HAVING
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
	COUNT(first_name) > 250
GROUP BY first_name
ORDER BY first_name; #causes an error

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name; #causes an error

SELECT *, AVG(salary) FROM salaries WHERE salary > 120000 GROUP BY emp_no ORDER BY emp_no; #returns an error
SELECT emp_no, AVG(salary) FROM salaries GROUP BY emp_no HAVING AVG(salary) > 120000 ORDER BY emp_no;

SELECT 
    first_name, hire_date, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

SELECT 
    emp_no, COUNT(from_date) AS signed_contract
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no; 

# Limit
SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

# INSERT STATEMENT
SELECT * FROM employees LIMIT 10;

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date) 
VALUES (999901, '1986-04-21', 'John', 'Smith', 'M', '2011-01-01');

SELECT * FROM employees ORDER BY emp_no DESC LIMIT 10;

INSERT INTO employees
VALUES(999903, '1977-09-04', 'Johnathan', 'Creek', 'M', '1999-01-01');

DELETE FROM employees WHERE emp_no = 999909;

SELECT * FROM titles LIMIT 10;
INSERT INTO titles (emp_no, title, from_date)
VALUES (999903, 'Senior Engineer', '1997-10-01');
SELECT * FROM titles ORDER BY emp_no DESC LIMIT 10;

SELECT * FROM dept_emp ORDER BY emp_no DESC LIMIT 10;
INSERT INTO dept_emp
VALUES (999903, 'd005', '1997-10-01', '9999-01-01');

SELECT * FROM departments LIMIT 10;

# Copying values from other tables. Creating departments_duplicate
CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

INSERT INTO departments_dup(dept_no, dept_name)
SELECT * FROM departments;

SELECT * FROM departments_dup LIMIT 10;

INSERT INTO departments
VALUES ('d010', 'Business Analysis');

INSERT INTO departments_dup(dept_no, dept_name)
SELECT * FROM departments WHERE dept_no = 'd010';

#UPDATE 

SELECT * FROM employees WHERE emp_no = 999901;

UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999901;
    
# ROLLBACK
SELECT * FROM departments_dup ORDER BY dept_no;

UPDATE departments_dup
SET
	dept_no = 'd011',
	dept_name = 'Quality Control';
    
ROLLBACK;
COMMIT;

UPDATE departments
SET
	dept_name = 'Data Analysis'
WHERE
	dept_name = 'Business Analysis';

SELECT * FROM departments ORDER BY dept_no;

COMMIT;

SELECT * FROM employees WHERE emp_no = 999903;
SELECT * FROM titles WHERE emp_no = 999903;

DELETE FROM employees WHERE emp_no = 999903;

ROLLBACK;
COMMIT;

DELETE FROM departments 
WHERE
    dept_no = 'd010';
 
#COUNT
SELECT * FROM salaries ORDER BY salary DESC LIMIT 10;

SELECT 
    COUNT(salary)
FROM
    salaries;
    
SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;
# returns also null values
SELECT 
    COUNT(*)
FROM
    salaries;

SELECT COUNT(DISTINCT dept_no) FROM dept_emp;

# SUM
SELECT * FROM salaries;

SELECT SUM(salary) FROM salaries WHERE from_date > '1997-01-01';

# MIN AMX 
SELECT MAX(salary) FROM salaries;
SELECT MIN(salary) FROM salaries;

SELECT MIN(emp_no) FROM employees;

#AVG
SELECT AVG(salary) FROM salaries;
SELECT (salary) FROM salaries;

SELECT AVG(salary) FROM salaries WHERE from_date > '1997-01-01';

#ROUND 
SELECT ROUND(AVG(salary),2) FROM salaries;

#COALESCE and IF NULL
SELECT * FROM departments_dup ORDER BY dept_no ASC;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup(dept_no) VALUES ('d011'), ('d012');

ALTER TABLE departments_dup
ADD COLUMN dept_manager VARCHAR(255) NULL AFTER dept_name;

COMMIT;

SELECT 
    dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup;
    
SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'NA') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    dept_no,
    dept_name,
    COALESCE('department manager name') AS fake_col
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT
    IFNULL(dept_no, 'N/A') as dept_no,
    IFNULL(dept_name, 'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

# ADJUSTING DEPARTMENTS_DUP FOR JOIN
SELECT * FROM departments_dup ORDER BY dept_no;

ALTER TABLE departments_dup
DROP dept_manager;

DELETE FROM departments_dup WHERE dept_no = 'd010';

UPDATE departments_dup 
SET 
    dept_no = 'd010'
WHERE
    dept_no = 'd011';
    
UPDATE departments_dup 
SET 
    dept_no = 'd011'
WHERE
    dept_no = 'd012';
    
COMMIT;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

INSERT INTO dept_manager_dup
SELECT * FROM dept_manager;

SELECT * FROM dept_manager_dup;
INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES (999904, '2017-01-01'),
		(999905, '2017-01-01'),
        (999906, '2017-01-01'),
        (999907, '2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002'; 

# JOIN 
SELECT * FROM dept_manager_dup ORDER BY dept_no;
SELECT * FROM departments_dup ORDER BY dept_no;

# inner join - represented by the common area of 2 columns
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no # Dealing with duplicate values
ORDER BY m.dept_no; # No null values and no values that don't appear in both tables

# inner join exercise
SELECT * FROM dept_manager_dup;
SELECT * FROM employees;

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager_dup m ON e.emp_no = m.emp_no
ORDER BY e.emp_no;

# LEFT JOIN
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

# LEFT JOIN INVERTING ORDER OF TABLES
# LEFT JOIN
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
WHERE
	dept_name IS NULL
ORDER BY d.dept_no;

# LEFT JOIN - Exercise
SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager_dup m ON e.emp_no = m.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY m.dept_no DESC , e.emp_no;

# RIGHT JOIN

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        RIGHT JOIN
    dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

# OLD JOIN SYNTAX (using where)
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m,
    departments_dup d
WHERE
	m.dept_no = d.dept_no
ORDER BY m.dept_no; # No null values and no values that don't appear in both tables

# OLD Join syntax exercise
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE
    e.emp_no = dm.emp_no;
    
# JOIN AND WHERE used together
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    salary > 145000
ORDER BY s.salary ASC;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

# JOIN + WHERE exercise
SELECT * FROM employees;
SELECT * FROM titles;

SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta' AND last_name = 'Markovitch'
ORDER BY e.emp_no ASC;

# CROSS JOIN
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT * FROM dept_manager;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT * FROM dept_manager;

SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
		JOIN
	employees e ON dm.emp_no = e.emp_no
WHERE
	d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

# CROSS JOIN Exercise
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

# AGGREGATE WITH JOINS
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

#JOIN more than two tables
SELECT * FROM salaries;
SELECT 
    e.first_name,
    e.last_name,
    AVG(s.salary) AS average_salary,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
	salaries s ON e.emp_no = s.emp_no
		JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
GROUP BY e.emp_no;

# Exercise
SELECT 
    e.first_name,
    e.last_name,
    t.title,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
	titles t ON e.emp_no = t.emp_no
		JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

# Tips and Tricks for joins
# Obtaining dept_name and avg_salary
SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY(d.dept_name)
HAVING average_salary > 60000
ORDER BY average_salary DESC;

# Exercise
SELECT * FROM employees;
SELECT * FROM dept_manager;

SELECT 
    e.gender, COUNT(dm.emp_no) AS gender_count
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

# UNION vs UNION ALL
DROP TABLE IF EXISTS employees_dup;
CREATE TABLE employees_dup (
    emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);

INSERT INTO employees_dup
SELECT 
	e.*
FROM 
	employees e
LIMIT 20;

INSERT INTO employees_DUP VALUES
('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

SELECT * FROM employees_dup;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
    
# Exercise
SELECT
    *
FROM
    (SELECT
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) as a
ORDER BY -a.emp_no DESC;

# Subqueries with IN nested inside WHERE
SELECT * FROM dept_manager;

# Select the first and last name from the "Employees table for the same
# employee numbers that can be found in the "Department Manager" table
SELECT * from dept_manager;
SELECT 
    e.emp_no, e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
# Exercise
SELECT * FROM employees;
SELECT 
    *
FROM
    dept_manager dm
WHERE
    dm.emp_no IN (SELECT 
            e.emp_no
        FROM
            employees e
        WHERE
            e.hire_date BETWEEN '1990-01-01' AND '1995-01-01');

SELECT * from salaries;

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            t.emp_no
        FROM
            titles t
        WHERE
            t.title = 'Manager');
            
# Subqueries with EXISTS
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS (SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no;

# Exercise
SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND t.title = 'Assistant Engineer');
                
SELECT * FROM titles WHERE title = 'Assistant Engineer';

Select * from departments;
# SELECT and FROM

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            e.first_name,
            e.last_name,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    employees
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            e.first_name,
            e.last_name,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    employees
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
# Exercise
DROP TABLE IF EXISTS emp_manager;
CREATE TABLE emp_manager (
    emp_no INT NOT NULL,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    dept_no CHAR(4) NULL,
    manager_no INT NOT NULL
);
INSERT INTO emp_manager
SELECT 
    U.*
FROM
    (SELECT 
        A.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            e.first_name,
            e.last_name,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    employees
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
    
    UNION SELECT 
        B.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            e.first_name,
            e.last_name,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    employees
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B 
    
    UNION SELECT 
        C.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            e.first_name,
            e.last_name,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    employees
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS C 
    
    UNION SELECT 
        D.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            e.first_name,
            e.last_name,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    employees
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS D) AS U;
    
    SELECT * FROM emp_manager;

# SELF JOIN
SELECT 
    e2.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);
            
SELECT 
    manager_no
FROM
    emp_manager;
    
# VIEWS
SELECT * FROM dept_emp;

SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS Num
FROM
    dept_emp
GROUP BY emp_no
HAVING Num > 1;

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no;

# Views Exercise
SELECT * FROM salaries;

CREATE OR REPLACE VIEW v_avg_manager_salary AS
SELECT 
    ROUND(AVG(s.salary),2) AS avg_salary
FROM
    salaries s
WHERE
    s.emp_no IN (SELECT 
            t.emp_no
        FROM
            titles t
        WHERE
            t.title = 'Manager');

# Other solution
CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;
        
# Stored Routines
# Stored Procedures (non-parametric)
USE employees;

DROP PROCEDURE IF EXISTS select_employees;
DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN

	SELECT * FROM employees
    LIMIT 1000;    

END$$

DELIMITER ;

CALL employees.select_employees();

# Exercise 
DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN

	SELECT AVG(salary) from salaries;        

END$$

DELIMITER ;

CALL avg_salary();
DROP PROCEDURE select_employees;

# Stored Procedures (with parameters)
# input parameters
DROP PROCEDURE IF EXISTS emp_salary;
DELIMITER $$
CREATE PROCEDURE emp_salary (IN p_emp_no INTEGER)
BEGIN
	SELECT 
		e.first_name, e.last_name, s.salary, s.from_date, s.to_date
	FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no; #parameter used here
END$$

DELIMITER ; 

CALL employees.emp_salary(11300);

DELIMITER $$
CREATE PROCEDURE emp_avg_salary (IN p_emp_no INTEGER)
BEGIN
	SELECT 
		e.first_name, e.last_name, AVG(s.salary)
	FROM
		employees e
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no; #parameter used here
END$$

DELIMITER ; 

CALL employees.emp_avg_salary(12558);

# Output parameters
DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out (IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
	SELECT 
    AVG(s.salary)
INTO p_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$

DELIMITER ;


DELIMITER $$
CREATE PROCEDURE emp_info (IN p_first_name VARCHAR(255), IN p_last_name VARCHAR(255), OUT p_emp_no INTEGER)
BEGIN
	SELECT 
	e.emp_no
INTO p_emp_no FROM
    employees e
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
END$$
DELIMITER ;

CALL emp_info('Bezalel', 'Simmel', @p_emp_no);
SELECT @p_emp_no;

SELECT * FROM employees;

# Variables
SET @v_avg_salary = 0;
CALL employees.emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

SET @v_emp_no = 0;
CALL employees.emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

# User-defined functions
DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
    
RETURN v_avg_salary;
END$$

DELIMITER ;    

# Exercise
DROP FUNCTION IF EXISTS f_emp_last_salary;
DELIMITER $$
CREATE FUNCTION f_emp_last_salary (p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_salary_last_contract DECIMAL(10,2);

SELECT 
    MAX(s.salary)
INTO v_salary_last_contract FROM
    employees e
        JOIN
    salaries s ON s.emp_no = e.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
        
RETURN v_salary_last_contract;

END$$

DELIMITER ;

# Alternate solution

DROP FUNCTION IF EXISTS f_emp_last_salary_alternate;
DELIMITER $$
CREATE FUNCTION f_emp_last_salary_alternate (p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_salary_last_contract DECIMAL(10,2);
DECLARE v_max_from_date DATE;

SELECT 
    MAX(s.from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON s.emp_no = e.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
        
SELECT 
    s.salary
INTO v_salary_last_contract FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;

RETURN v_salary_last_contract;

END$$

DELIMITER ;

SELECT * FROM employees;
SELECT salary, from_date FROM salaries WHERE emp_no = 10162;

# Advanced SQL Topics
# Triggers
# exercise
SELECT * FROM employees;

DELIMITER $$
CREATE TRIGGER trig_hire_date_check
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	
	IF NEW.hire_date > DATE_FORMAT(SYSDATE(), '%y-%m-%d') THEN
		SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%y-%m-%d');
    END IF;
END$$

DELIMITER ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');
SELECT  
    *  
FROM  
    employees
ORDER BY emp_no DESC;

DELETE FROM employees WHERE emp_no = 999904;

INSERT employees VALUES ('999922', '1970-01-31', 'Jack', 'Johnson', 'M', '2025-01-01');

DELETE FROM employees WHERE emp_no = 999922;


# INDEXES
CREATE INDEX i_hire_date ON employees(hire_date);
# Composite indexes
CREATE INDEX i_composite_flname ON employees(first_name, last_name);

SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';

SHOW INDEX FROM employees FROM employees;

# Exercise
ALTER TABLE employees
DROP INDEX i_hire_date;

SELECT * FROM salaries;

SELECT * FROM salaries WHERE salary > 89000;

CREATE INDEX i_salary ON salaries(salary);

# CASE
# 2 examples of syntax
SELECT 
    emp_no,
    first_name,
    last_name,
    CASE gender
        WHEN 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
	employees e;
    
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 
									'Salary was raised by more than $20,000 but less than $30,000'
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

# Exercises
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;

SELECT
	dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diff,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Raise > $ 30000'
        ELSE 'Raise < $ 30000'
	END AS raise_analysis
FROM 
	employees e
		JOIN
	dept_manager dm ON e.emp_no = dm.emp_no
		JOIN
	salaries s ON dm.emp_no = s.emp_no
GROUP BY s.emp_no;

SELECT
	dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diff,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Raise > $ 30000'
        ELSE 'Raise < $ 30000'
	END AS raise_analysis
FROM 
	dept_manager dm
		JOIN
	employees e ON e.emp_no = dm.emp_no
		JOIN
	salaries s ON dm.emp_no = s.emp_no
GROUP BY s.emp_no;

SELECT * FROM dept_emp;

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    de.to_date,
    CASE 
		WHEN MAX(de.to_date) > SYSDATE() THEN 'Not an employee anymore'
        ELSE 'Is still employed'
	END AS current_employee
    FROM
		employees e
			JOIN
		dept_emp de ON e.emp_no = de.emp_no
GROUP BY de.emp_no
LIMIT 100;

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;