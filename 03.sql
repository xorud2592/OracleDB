-- ROLLUP
-- GROUP BY ���� �Բ� ���
-- GROUP BY�� ����� ���� ���� ����� �����ϴ� ��� ���� (Item Subtotal)
-- �μ��� �޿��� �հ� ����(�μ� ���̵�, job_id)
SELECT department_id,
    job_id,
    SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

SELECT department_id,
    job_id,
    SUM(salary)
FROM employees
GROUP BY ROLLUP(department_id, job_id);


-- CUBE �Լ�
-- CrossTable�� ���� Summary�� �Բ� ����
-- Rollup �Լ��� ����� Subtotal�� 
-- Column Total ���� ������ �� �ִ�
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id;

----------
-- Subquery
----------
/* 
�ϳ��� SQL�� �ٸ� SQL ������ �Ϻο� ���ԵǴ� ���
*/
-- ������ ��������
--  ���������� ����� �������� ���, ������ �� �����ڸ� ���(=, >, >=, <, <=, <>)

-- 'Den' ���� �޿��� ���� �޴� ����� �̸��� �޿���?
-- 1. Den�� �󸶳� �޿��� �޴��� - A
-- 2. A���� ���� �޿��� �޴� �����?
SELECT salary FROM employees WHERE first_name='Den';    --  11000 : 1
SELECT first_name, salary FROM employees WHERE salary > 11000;  -- : 2
-- ��ģ��
SELECT first_name, salary FROM employees
WHERE salary > (SELECT salary FROM employees WHERE first_name='Den');

-- ����: 
-- �޿��� �߾Ӱ����� ���� �޴� ����
-- 1. �޿��� �߾Ӱ�?
-- 2. �޿��� �߾Ӱ����� ���� �޴� ����
SELECT MEDIAN(salary) FROM employees;   --  6200 : 1
SELECT first_name, salary FROM employees WHERE salary > 6200;
-- ���� ��ġ��
SELECT first_name, salary FROM employees
WHERE salary > (SELECT MEDIAN(salary) FROM employees);

-- �޿��� ���� ���� �޴� ����� �̸�, �޿�, ��� ��ȣ�� ����Ͻÿ�
SELECT MIN(salary) FROM employees;  --  2100
SELECT first_name, salary, employee_id
FROM employees
WHERE salary = 2100;
-- ���� ��ġ��
SELECT first_name, salary, employee_id
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

-- ������ ��������
-- �������� ��� ���ڵ尡 �� �̻��� ���, �ܼ� �� �Ұ���
-- ���� ���꿡 ���õ� IN, ANY, ALL, EXSIST ���� �̿��ؾ� �Ѵ�

-- 110�� �μ��� ������ �޴� �޿���?
SELECT salary FROM employees WHERE department_id = 110; -- ���ڵ� ���� 2
SELECT first_name, salary FROM employees
WHERE salary = (SELECT salary FROM employees WHERE department_id = 110);
-- Error: ���������� ��� ���ڵ�� 2�� 
--  2���� ����� ������ salary�� ���� ���� �� ����

-- Fix
SELECT first_name, salary FROM employees
WHERE salary IN (SELECT salary FROM employees WHERE department_id = 110); -- IN
SELECT first_name, salary FROM employees
WHERE salary = ANY (SELECT salary FROM employees WHERE department_id = 110); -- ANY

-- IN, =ANY -> OR�� ���

SELECT first_name, salary FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 110); -- ALL
-- ALL: AND�� ���

SELECT first_name, salary FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 110);
-- salary > 12008 OR salary > 8300 -> ����

-- Correlated Query
-- ������ ����(Outer Query), ���Ե� ����(Inner Query)�� ���� �������踦 �δ� ����
SELECT first_name, salary, department_id
FROM employees outer -- Outer
WHERE salary > (SELECT AVG(salary) FROM employees
                WHERE department_id = outer.department_id);
-- �ǹ�
-- ��� ����� �����ϵ�
--  �ڽ��� ���� �μ��� ��� �޿����� ���� �޴� ������ �������ڴ� �ǹ�
--   ��������(INNER)�� ����Ǳ� ���� OUTER�� �÷����� �ʿ��ϰ�
--      OUTER ���� ������ �Ϸ�Ǳ� ���ؼ��� ��������(INNERT)�� ��� ���� �ʿ��� ����

-- �������� ����
-- �� �μ����� �ְ� �޿��� �޴� ����� ���
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

-- 1. ���������� ��
SELECT department_id, employee_id, first_name, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary) 
                                    FROM employees
                                    GROUP BY department_id)
ORDER BY department_id;

-- SUBQUERY: �ӽ����̺��� ����
-- 2. �μ��� �ְ� �޿� ���̺��� �ӽ÷� �����ؼ� ���̺�� �����ϴ� ���
SELECT emp.department_id, employee_id, first_name, emp.salary
FROM employees emp, (SELECT department_id, MAX(salary) salary
                        FROM employees
                        GROUP BY department_id) sal -- �ӽ����̺��� ���� sal ��Ī�� �ο�
WHERE emp.department_id = sal.department_id AND
    emp.salary = sal.salary
ORDER BY emp.department_id;

-- 3. Correlated Query Ȱ��
SELECT emp.department_id, employee_id, first_name, emp.salary
FROM employees emp
WHERE emp.salary = (SELECT MAX(salary) FROM employees
                    WHERE department_id = emp.department_id)
ORDER BY department_id;                    

----------
-- TOP K Query
----------
-- Oracle�� ���� ���� ����� ���ȣ�� Ȯ���� �� �ִ� ���� �÷� rownum�� ����

-- 2007�� �Ի��� �߿��� �޿� ���� 5������ �̾ƺ��ô�
SELECT rownum, first_name, salary
FROM employees; --  OK

SELECT rownum, first_name, salary
FROM employees
WHERE hire_date LIKE '07%' AND rownum <= 5; 

SELECT rownum, first_name, salary
FROM employees
WHERE hire_date LIKE '07%' AND rownum <= 5
ORDER BY salary DESC;   --  rownum�� ������ ���� ������ ����

-- TOP K ����
SELECT rownum, first_name, salary 
FROM (SELECT * FROM employees
        WHERE hire_date LIKE '07%'
        ORDER BY salary DESC)
WHERE rownum <= 5;

-- SET (����)
-- UNION(������: �ߺ�����), UNION ALL(������: �ߺ����� ����)
-- INTERSECT(������), MINUS(������)
SELECT first_name, salary, hire_date FROM employees WHERE hire_date < '05/01/01';   -- 24
SELECT first_name, salary, hire_date FROM employees WHERE salary > 12000;   -- 8

-- ������
SELECT first_name, salary, hire_date FROM employees WHERE hire_date < '05/01/01'
INTERSECT
SELECT first_name, salary, hire_date FROM employees WHERE salary > 12000;

-- ���� �Ͱ� ���� �ǹ�
SELECT first_name, salary, hire_date FROM employees
WHERE hire_date < '05/01/01' AND
    salary > 12000;

-- ������: UNION
SELECT first_name, salary, hire_date FROM employees WHERE hire_date < '05/01/01'
UNION
SELECT first_name, salary, hire_date FROM employees WHERE salary > 12000;  -- 26

-- ���� ���� �Ʒ��� ���� �ǹ�
SELECT first_name, salary, hire_date 
FROM employees 
WHERE hire_date < '05/01/01' OR salary > 12000;

-- ������: MINUS
SELECT first_name, salary, hire_date FROM employees WHERE hire_date < '05/01/01'
MINUS
SELECT first_name, salary, hire_date FROM employees WHERE salary > 12000;

-- �Ի����� 05/01/01 ������ ����� ��, �޿��� 12000������ ������
SELECT first_name, salary, hire_date
FROM employees
WHERE hire_date < '05/01/01' AND
    NOT (salary > 12000);
    
-- RANK �Լ�
SELECT salary, first_name,
    RANK() OVER (ORDER BY salary DESC) as rank, --  �ߺ��� ������ �ǳʶٰ� ���� �ο�
    DENSE_RANK() OVER (ORDER BY salary DESC) as dense_rank, -- �ߺ����� ��� ���� ���� ���� �ο�
    ROW_NUMBER() OVER (ORDER BY salary DESC) as row_number, -- �ߺ� ���� ������� ���ʴ�� ���� �ο�
    rownum  --  ���ĵǱ� ������ ���ڵ� ����
FROM employees;

-- Hierarchical Query : Ʈ�� ������ ������ ����
--  ROOT ���: ���� START WITH�� ����
--  ����: �����ϱ� ���� ������ CONNECT BY PROIR �� ����
-- employees ���̺�� ������ �׷����ô�.
--  level(����)�̶�� ���� �÷��� ����Ҽ� �ִ�
SELECT level, first_name, manager_id, employee_id
FROM employees
START WITH manager_id IS NULL   -- ROOT ����� ����
CONNECT BY PRIOR employee_id = manager_id
ORDER BY level;