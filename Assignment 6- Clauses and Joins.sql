CREATE DATABASE employee;

USE employee;


CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(100)
);


CREATE TABLE location (
    location_id INT,
    location VARCHAR(30)
);


CREATE TABLE employees (
    employee_id INT,
    employee_name VARCHAR(50),
    gender ENUM('M', 'F'),
    age INT,
    hire_date DATE,
    designation VARCHAR(100),
    department_id INT,
    location_id INT,
    salary DECIMAL(10, 2)
);


ALTER TABLE employees ADD COLUMN email VARCHAR(100);


ALTER TABLE employees MODIFY COLUMN designation VARCHAR(255);

ALTER TABLE employees DROP COLUMN age;

ALTER TABLE employees RENAME COLUMN hire_date TO date_of_joining;



DROP DATABASE IF EXISTS employee;
CREATE table employee;
USE employee;

CREATE TABLE location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(30) NOT NULL UNIQUE
);


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,                                  
    employee_name VARCHAR(50) NOT NULL,                           
    gender ENUM('M', 'F') NOT NULL,                               
    age INT CHECK (age >= 18),                                    
    hire_date DATE DEFAULT (CURRENT_DATE),                        
    designation VARCHAR(100),
    department_id INT,
    location_id INT,
    salary DECIMAL(10, 2),

    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_location FOREIGN KEY (location_id) REFERENCES location(location_id)
);

INSERT INTO location (location_id, location) VALUES 
(1, 'New York'),
(2, 'London'),
(3, 'Tokyo');

INSERT INTO departments (department_id, department_name) VALUES 
(101, 'Finance'),
(102, 'HR'),
(103, 'IT');

INSERT INTO employees (employee_id, employee_name, gender, age, hire_date, designation, department_id, location_id, salary) VALUES 
(1, 'Alice Smith', 'F', 28, '2015-06-15', 'Analyst', 101, 1, 55000.00),
(2, 'Bob Jones', 'M', 35, '2017-03-20', 'Manager', 102, 2, 65000.00),
(3, 'Charlie Brown', 'M', 24, '2018-01-10', 'Junior Analyst', 101, 1, 45000.00),
(4, 'Diana Prince', 'F', 29, '2018-05-12', NULL, 103, 3, 70000.00),
(5, 'Evan Wright', 'M', 40, '2014-11-05', 'Director', 101, 1, 90000.00);

SELECT * FROM employees;

SELECT * FROM location;

SELECT * FROM departments;


SELECT DISTINCT salary 
FROM Employees;


SELECT age AS Employee_Age, salary AS Employee_Salary 
FROM Employees;

SELECT * FROM Employees 
WHERE salary > 50000 AND hire_date < '2016-01-01';

UPDATE Employees 
SET designation = 'Data Scientist' 
WHERE designation IS NULL OR designation = '';


SELECT * 
FROM Employees 
WHERE YEAR(hire_date) = 2018 
ORDER BY hire_date ASC 
LIMIT 5;

SELECT SUM(e.salary) AS Total_Finance_Salary 
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';


SELECT MIN(age) AS Minimum_Age 
FROM Employees;


SELECT location, MAX(salary) AS Max_Salary 
FROM Employees 
GROUP BY location;

SELECT designation, AVG(salary) AS Average_Salary 
FROM Employees 
WHERE designation LIKE '%Analyst%' 
GROUP BY designation;

SELECT department_id, COUNT(*) AS Employee_Count 
FROM Employees 
GROUP BY department_id 
HAVING COUNT(*) < 3;

SELECT location 
FROM Employees 
WHERE gender = 'Female' 
GROUP BY location 
HAVING AVG(age) < 30;


SELECT e.employee_name, e.designation, d.department_name 
FROM Employees e
INNER JOIN Departments d ON e.department_id = d.department_id;

SELECT d.department_name, COUNT(e.employee_id) AS Total_Employees 
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

SELECT l.location_name, e.employee_name 
FROM Employees e
RIGHT JOIN Locations l ON e.location_id = l.location_id;
