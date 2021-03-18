--���̺� ����(JOIN) SQL �����Դϴ�.
--����1.
--�������� ���(employee_id), �̸�(firt_name), ��(last_name)�� �μ���(department_name)��
--��ȸ�Ͽ� �μ��̸�(department_name) ��������, ���(employee_id) �������� ���� �����ϼ���.
--(106��)
SELECT employee_id ���, first_name �̸�, 
    last_name ��, department_id �μ���
FROM employees
WHERE department_id is not null
ORDER BY �μ���, ��� DESC;

SELECT emp.employee_id, emp.first_name, emp.last_name, dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id
ORDER BY dept.department_name,
    emp.department_id DESC;

SELECT emp.employee_id, emp.first_name, emp.last_name, dept.department_name
FROM employees emp NATURAL JOIN departments dept
ORDER BY dept.department_name,
    emp.department_id DESC;
    
--����2.
--employees ���̺��� job_id�� ������ �������̵� ������ �ֽ��ϴ�.
--�������� ���(employee_id), �̸�(firt_name), �޿�(salary), �μ���(department_name), ��
--�����(job_title)�� ���(employee_id) �������� ���� �����ϼ���.
--�μ��� ���� Kimberely(��� 178)�� ǥ������ �ʽ��ϴ�.
--(106��)

SELECT employees.employee_id ���, employees.first_name �̸�, 
    employees.salary �޿�, departments.department_id �μ���,
    jobs.job_id �������
FROM employees, departments, jobs
WHERE employees.department_id = departments.department_id AND 
    employees.job_id = jobs.job_id;

--����2-1.
--����2���� �μ��� ���� Kimberely(��� 178)���� ǥ���� ������
--(107��)
SELECT employee_id ���, first_name �̸�, 
    salary �޿�, department_id �μ���,
    job_id �������
FROM employees
ORDER BY ���;

SELECT employees.employee_id ���, employees.first_name �̸�, 
    employees.salary �޿�, departments.department_id �μ���,
    jobs.job_id �������
FROM employees, departments, jobs
WHERE employees.department_id = departments.department_id (+) AND 
    employees.job_id = jobs.job_id;
    
SELECT emp.employee_id ���, emp.first_name �̸�, 
emp.salary �޿�, dept.department_id �μ���,
jobs.job_id �������
FROM employees emp LEFT OUTER JOIN departments dept ON emp.department_id = dept.department_id, jobs
WHERE emp.job_id = jobs.job_id;

--����3.
--���ú��� ��ġ�� �μ����� �ľ��Ϸ��� �մϴ�.
--���þ��̵�, ���ø�, �μ���, �μ����̵� ���þ��̵�(��������)�� �����Ͽ� ����ϼ���
--�μ��� ���� ���ô� ǥ������ �ʽ��ϴ�.
--(27��)

SELECT dep.location_id ���þ��̵�, loc.city ���ø�, dep.department_name �μ���, dep.department_id �μ����̵�
FROM departments dep JOIN locations loc ON dep.location_id = loc.location_id
ORDER BY ���þ��̵�;

SELECT dep.location_id ���þ��̵�, loc.city ���ø�, dep.department_name �μ���, dep.department_id �μ����̵�
FROM departments dep JOIN locations loc ON dep.location_id = loc.location_id
ORDER BY ���þ��̵�;
--����3-1.
--����3���� �μ��� ���� ���õ� ǥ���մϴ�.
--(43��)

SELECT loc.location_id ���þ��̵�, city ���ø�, department_name �μ���, dep.department_id �μ����̵�
FROM departments dep RIGHT OUTER JOIN locations loc ON  loc.location_id = dep.location_id
ORDER BY ���þ��̵�;

SELECT loc.location_id ���þ��̵�, city ���ø�, department_name �μ���, dep.department_id �μ����̵�
FROM departments dep, locations loc 
WHERE loc.location_id = dep.location_id(+)
ORDER BY ���þ��̵�;


--����4.
--����(regions)�� ���� ������� �����̸�(region_name), �����̸�(country_name)���� ����ϵ� �����̸�(��������), �����̸�(��������) ���� �����ϼ���.
--(25��)

SELECT reg.region_name �����̸�, con.country_name �����̸�
FROM countries con JOIN regions reg ON con.region_id = reg.region_id
ORDER BY �����̸�, �����̸� DESC;

--����5.
--�ڽ��� �Ŵ������� ä����(hire_date)�� ���� �����
--���(employee_id), �̸�(first_name)�� ä����(hire_date), �Ŵ����̸�(first_name), �Ŵ�����
--����(hire_date)�� ��ȸ�ϼ���.
--(37��)
SELECT emp.employee_id, emp.first_name, emp.hire_date,
    man.first_name, man.hire_date
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id AND
    emp.hire_date < man.hire_date;

--����6.
--���󺰷� ��� �μ����� ��ġ�ϰ� �ִ��� �ľ��Ϸ��� �մϴ�.
--�����, ������̵�, ���ø�, ���þ��̵�, �μ���, �μ����̵� �����(��������)�� �����Ͽ�
--����ϼ���.
--���� ���� ��� ǥ������ �ʽ��ϴ�.
--(27��)
SELECT con.country_name , con.country_id, loc.city, loc.location_id, dept.department_name, dept.department_id
FROM departments dept JOIN locations loc on dept.location_id = loc.location_id, countries con
WHERE loc.country_id = con.country_id
ORDER BY con.country_name;

SELECT con.country_name , con.country_id, loc.city, loc.location_id, dept.department_name, dept.department_id
FROM departments dept, locations loc, countries con
WHERE dept.location_id = loc.location_id AND loc.country_id = con.country_id
ORDER BY con.country_name;

--����7.
--job_history ���̺��� ������ �������� �����͸� ������ �ִ�.
--������ �������̵�(job_id)�� ��AC_ACCOUNT���� �ٹ��� ����� ���, �̸�(Ǯ����), ��������
--��, ������, �������� ����ϼ���.
--�̸��� first_name�� last_name�� ���� ����մϴ�.
--(2��)
SELECT employees.department_id ���, 
    CONCAT(CONCAT(employees.first_name, ' '), employees.last_name) �̸�, 
    job_history.start_date ����������, 
    job_history.end_date ����������
FROM job_history, employees
WHERE job_history.employee_id = employees.employee_id AND job_history.job_id = 'AC_ACCOUNT';

--����8.
--�� �μ�(department)�� ���ؼ� �μ���ȣ(department_id), �μ��̸�(department_name),
--�Ŵ���(manager)�� �̸�(first_name), ��ġ(locations)�� ����(city), ����(countries)�� �̸�
--(countries_name) �׸��� ��������(regions)�� �̸�(resion_name)���� ���� ����� ������.
--(11��)
SELECT dep.department_id, dep.department_name, emp.first_name, loc.city, con.country_name, reg.region_name
FROM employees emp, departments dep, locations loc, countries con, regions reg
WHERE dep.manager_id = emp.employee_id AND 
    dep.location_id = loc.location_id AND
    loc.country_id = con.country_id AND
    con.region_id = reg.region_id;

--����9.
--�� ���(employee)�� ���ؼ� ���(employee_id), �̸�(first_name), �μ���
--(department_name), �Ŵ���(manager)�� �̸�(first_name)�� ��ȸ�ϼ���.
--�μ��� ���� ����(Kimberely)�� ǥ���մϴ�.
--(106��)
SELECT emp.employee_id ���, emp.first_name �̸�,
    dep.department_name �μ���, 
    man.first_name "�Ŵ��� �̸�"
FROM employees emp, departments dep, employees man
WHERE emp.department_id = dep.department_id (+) AND
    emp.manager_id = man.employee_id;
