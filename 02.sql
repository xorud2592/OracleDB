DESC employees;
DESC departments;

SELECT employees.employee_id, employees.department_id, 
    departments.department_id, departments.department_name
FROM employees, departments
ORDER BY employees.employee_id;

SELECT emp.employee_id, emp.first_name, emp.department_id,
    dept.department_id, dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;

SELECT * 
FROM employees emp, departments dept;


SELECT first_name,
    emp.department_id,
    dept.department_id
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;

SELECT first_name , department_id
FROM employees
WHERE department_id is null;

SELECT first_name,
    department_id
    department_name
FROM employees JOIN departments dept USING(department_id);

SELECT first_name,
    emp.department_id,
    department_name
FROM employees emp JOIN departments dept ON(emp.department_id = dept.department_id);

SELECT first_name,
    department_id,
    department_name
FROM employees  NATURAL JOIN departments;

SELECT * FROM jobs WHERE job_id= 'AD_ASST';

SELECT first_name, salary FROM employees emp, jobs j 
WHERE j.job_id= 'AD_ASST' AND
    salary BETWEEN j.min_salary AND j.max_salary;

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id (+);


SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp LEFT OUTER JOIN departments dept ON emp.department_id = dept.department_id;

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id (+)= dept.department_id;

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id (+);


SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp RIGHT OUTER JOIN departments dept ON emp.department_id = dept.department_id;

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id (+) = dept.department_id (+); --ºÒ°¡´É

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp FULL OUTER JOIN departments dept
                ON emp.department_id = dept.department_id;


SELECT emp.employee_id, emp.first_name,
    emp.manager_id,
    man.first_name
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id;

SELECT emp.employee_id, emp.first_name,
    emp.manager_id,
    man.first_name
FROM employees emp JOIN employees man 
                ON emp.manager_id = man.employee_id;
                
                
SELECT COUNT(*) FROM employees;
SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(*) FROM employees WHERE commission_pct is not null;


SELECT COUNT(*) FROM employees WHERE commission_pct is not null;
