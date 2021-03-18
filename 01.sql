-- ���� ���� ���� � ���̺��� �ִ°�?
SELECT * FROM tab;


-- ���̺��� ���� Ȯ�� DESC
DESC employees;

-- ��� �÷� Ȯ��
--   ���̺� ���ǵ� �÷��� �������
SELECT * FROM employees;

DESC departments;

SELECT * FROM department;

-- first_name, ��ȭ��ȣ, �Ի���, �޿�
SELECT first_name, phone_number, hire_date, salary FROM employees;

-- first_name, last_name, salary, ��ȭ��ȣ, �Ի���
SELECT first_name,
    last_name, 
    phone_number,
    hire_date,
    salary
FROM employees; 

-- ��� ����: �⺻���� ��� ������ ���
SELECT 3.14159 * 3 * 3 FROM employees; -- ��� ���ڵ带 �ҷ��ͼ� ��������� ���� 
SELECT 3.14159 * 3 * 3 FROM dual; -- �ܼ� ������ dual(�������̺�)�� �̿�

SELECT first_name, 
    salary, 
    salary * 12 -- ���ڵ� �� ��� salary �÷��� ���� ��������� ����
FROM employees;

SELECT job_id * 12 
FROM employees; -- Error: ��� ������ ��ġ �ڷ���������

DESC employees;

-- ����� �̸�, salary, commission_pct ���
SELECT first_name, salary, commission_pct
FROM employees;

--  ���Ŀ� null�� ���ԵǾ� ������ ����� null
SELECT first_name,
    salary,
    salary + (salary * commission_pct)
FROM employees;

-- nvl�Լ�: null -> �ٸ� �⺻ ������ ġȯ
-- null�� ó���� ���� �׻� ��������
SELECT first_name,
    salary + (salary * nvl(commission_pct, 0)) -- commission_pct null -> 0
FROM employees;

-- ���ڿ��� ���� (||)
-- ��Ī(Alias)
--  as ��� �ȴ�
--  ����, Ư�����ڰ� ���ԵǾ� ������ ��Ī�� "�� ����
SELECT first_name || ' ' || last_name as "FULL NAME"
FROM employees;

/*
�̸� : first_name last_name
�Ի���: hire_date
��ȭ��ȣ : phone_number
�޿� : salary
���� : salary * 12
*/

SELECT first_name || ' ' || last_name as "�̸�",
    hire_date �Ի���,
    phone_number ��ȭ��ȣ,
    salary �޿�,
    salary * 12 ����
FROM employees;

----------
-- WHERE : ���ǿ� �´� ���ڵ� ������ ���� ���� ��
----------
/*
�޿��� 15000 �̻��� ������� �̸��� ������ ����Ͻʽÿ�
07/01/01�� ���� �Ի��ڵ��� �̸��� �Ի����� ����Ͻʽÿ�.
�̸��� 'Lex'�� ����� ������ �Ի���, �μ� ID�� ����Ͻʽÿ�.
�μ� ID�� 10�� ����� ����� �ʿ��մϴ�.
*/

-- �޿��� 15000 �̻��� ������� �̸��� ������ ����Ͻʽÿ�
SELECT first_name || ' ' || last_name �̸�,
    salary * 12 ����
FROM employees
WHERE salary >= 15000;

-- 07/01/01�� ���� �Ի��ڵ��� �̸��� �Ի����� ����Ͻʽÿ�.
SELECT first_name || ' ' || last_name �̸�,
    hire_date
FROM employees
Where hire_date >= '07/01/01';

-- �̸��� 'Lex'�� ����� ������ �Ի���, �μ� ID�� ����Ͻʽÿ�.
SELECT first_name,
    salary * 12,
    hire_date,
    department_id
FROM employees
WHERE first_name = 'Lex';

-- �μ� ID�� 10�� ����� ����� �ʿ��մϴ�.
SELECT * FROM employees
WHERE department_id = 10;

/*
�޿��� 14000 �����̰ų� 17000 �̻��� ����� �̸��� �޿��� ����Ͻʽÿ�.
�μ� ID�� 90�� ��� ��, �޿��� 20000 �̻��� ����� �����Դϱ�?
*/
-- �޿��� 14000 �����̰ų� 17000 �̻��� ����� �̸��� �޿��� ����Ͻʽÿ�.
SELECT first_name, salary
FROM employees
WHERE salary <= 14000 OR salary >= 17000;

-- �μ� ID�� 90�� ��� ��, �޿��� 20000 �̻��� ����� �����Դϱ�?
SELECT * FROM employees
WHERE department_id = 90 AND salary >= 20000;

-- �޿��� 14000 �̻� 17000������ ����� �̸��� �޿��� ����Ͻÿ�
SELECT first_name, salary
FROM employees
WHERE salary >= 14000 AND salary <= 17000;

--  >= and <= -> Between���� 
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 14000 and 17000;

-- �Ի����� 07/01/01 ~ 07/12/31 ������ �ִ� ����� ����� ����� ���ô�
SELECT * FROM employees
WHERE hire_date >= '07/01/01' AND hire_date <= '07/12/31';

SELECT * FROM employees
WHERE hire_date BETWEEN '07/01/01' AND '07/12/31';

/*
�μ� ID�� 10, 20, 40�� ����� ����� ����� ���ô�
MANAGER ID�� 100, 120, 147 �� ����� ����� ����� ���ô�
- �񱳿�����+�������ڸ� �̿��Ͽ� ����� ����
- IN �����ڸ� �̿��� ����� ���ô�
- �� ������ ���� ���� IN �������� ������ ���� ������ ���ô�
*/

-- �μ� ID�� 10, 20, 40�� ����� ����� ����� ���ô�
SELECT * FROM employees
WHERE department_id = 10 OR
    department_id = 20 OR
    department_id = 40;
    
SELECT * FROM employees
WHERE department_id IN (10, 20, 40);    -- department_id �� 10, 20, 40 ���� �ϳ�

-- MANAGER ID�� 100, 120, 147 �� ����� ����� ����� ���ô�
SELECT * FROM employees
WHERE manager_id = 100 OR
    manager_id = 120 OR
    manager_id = 147;
    
SELECT * FROM employees
WHERE manager_id IN (100, 120, 147);

-- Ŀ�̼��� ���� �ʴ� ����� ��� => commission_pct �� null
-- is null 
SELECT first_name, commission_pct FROM employees
WHERE commission_pct is null;   --  null üũ�� = null �ϸ� �ȵȴ�

-- Ŀ�̼��� �޴� ����� ��� => commission_pct�� null �� �ƴ� ���
SELECT first_name, commission_pct FROM employees
WHERE commission_pct is not null; 

-- Like ����
-- % ������ ���� (0�� �� �ִ�)�� ���ڿ�
-- _ 1���� ���� ����

-- �̸��� am�� ������ ��� ����� %
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '%am%';

-- �̸��� �� ��° ���ڰ� a�� ����� ���
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '_a%';

/*
�μ� ��ȣ�� ������������ �����ϰ� �μ���ȣ, �޿�, �̸��� ����Ͻʽÿ�
�޿��� 10000 �̻��� ������ �̸��� �޿� ��������(���� �޿� -> ���� �޿�)���� ����Ͻʽÿ�
�μ� ��ȣ, �޿�, �̸� ������ ����ϵ� �μ���ȣ ��������, �޿� ������������ ����Ͻʽÿ�.
*/

-- �μ� ��ȣ�� ������������ �����ϰ� �μ���ȣ, �޿�, �̸��� ����Ͻʽÿ�
SELECT first_name, salary, department_id
FROM employees
ORDER BY department_id; --  �⺻ ���� ����� ASC(��������)

-- �޿��� 10000 �̻��� ������ �̸��� �޿� ��������(���� �޿� -> ���� �޿�)���� ����Ͻʽÿ�
SELECT first_name, salary FROM employees
WHERE salary >= 10000
ORDER BY salary DESC;   --  ���� ����

-- �μ� ��ȣ, �޿�, �̸� ������ ����ϵ� �μ���ȣ ��������, �޿� ������������ ����Ͻʽÿ�.
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id ASC, -- ASC ���� ����, 1�� ���� ����
    salary DESC;

----------
-- ������ �Լ�
-- ���� ���ڵ忡 ����Ǵ� �Լ�
----------

-- ���ڿ� ������ �Լ�
SELECT first_name, last_name,
    CONCAT(first_name, CONCAT(' ', last_name)) name,
    INITCAP(first_name || ' ' || last_name) name2, -- �� �ܾ��� ù���ڸ� �빮�ڷ�
    LOWER(first_name), -- ���� �ҹ���
    UPPER(first_name), -- ���� �빮��
    LPAD(first_name, 10, '*'), -- 10���� ��� ũ��, ���ڸ��� * ä��
    RPAD(first_name, 10, '*')
FROM employees;

-- first_name�� am�� ���Ե� ����� �̸� ���
SELECT first_name FROM employees
WHERE first_name LIKE '%am%';
    
SELECT first_name FROM employees;

--  Upper, Lower�� ��ҹ��� ���� ���� �˻��� �� ����
SELECT first_name FROM employees
WHERE lower(first_name) LIKE '%am%';

-- ����
SELECT '  Oracle  ', '*****Database*****'
FROM dual;

SELECT LTRIM('  Oracle  '), --  ���ʿ� �ִ� �� ������ ������
    RTRIM('  Oracle  '),    -- �����ʿ� �ִ� ������ ������
    TRIM('*' FROM '*****Database*****'), -- ���ڿ� ������ Ư�� ���ڸ� ����
    SUBSTR('Oracle Database', 8, 8), -- ���ڿ����� 8��° ���ں��� 8���ڸ� ����
    SUBSTR('Oracle Database', -8, 8) -- �ڿ������� 8��° ���ں��� 8���ڸ� ����
FROM dual;

-- ��ġ�� ������ �Լ�
SELECT ABS(-3.14),  -- ���밪
    CEIL(3.14), --  �ø�(õ��)
    FLOOR(3.14), -- ����(�ٴ�)
    Floor(7 / 3),    -- ��
    MOD(7, 3),  -- �������� ������
    POWER(2, 4),    -- ����: 2�� 4����
    ROUND(3.5),     -- �Ҽ��� ù°�ڸ� �ݿø�
    ROUND(3.5678, 2),   -- �Ҽ��� ��°�ڸ����� ǥ��, �Ҽ��� 3° �ڸ����� �ݿø�
    TRUNC(3.5),     --  �Ҽ��� ����
    TRUNC(3.5678, 2), -- �Ҽ��� ��°�ڸ����� ǥ��
    SIGN(-10)   -- ��ȣ �Լ�(����: -1, 0, ���:1)
FROM dual;

-- ��¥�� ������ �Լ�
SELECT sysdate FROM dual;   --  �ý��� ���� ���̺� -> 1��

SELECT sysdate FROM employees;  --  ���̺� ���� ���ڵ� ������ŭ ���

SELECT sysdate, -- �ý��� ��¥
    ADD_MONTHS(sysdate, 2), -- ���ú��� 2���� ��
    MONTHS_BETWEEN(TO_DATE('1999-12-31', 'YYYY-MM-DD'), sysdate),   -- ���� ��
    ROUND(sysdate, 'MONTH'),    --  ��¥ �ݿø�
    TRUNC(sysdate, 'MONTH')
FROM dual;

-- employees ������� �Ի����� �󸶳� ��������
SELECT first_name, hire_date,
    ROUND(MONTHS_BETWEEN(sysdate, hire_date), 1) as months
FROM employees;

----------
-- ��ȯ�Լ�
----------

/*
TO_CHAR(o, fmt): Number or Date -> Varchar
TO_NUMBER(s, fmt): Varchar -> Number
TO_DATE(s, fmt): Varchar -> Date
*/

-- TO_CHAR
SELECT first_name, 
    TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS') �Ի���
FROM employees;

-- ���� �ð��� ��-��-�� ����/���� ��:��:�� ������ ���
SELECT
    sysdate,
    TO_CHAR(sysdate, 'YYYY-MM-DD PM HH:MI:SS')
FROM dual;

SELECT first_name,
    TO_CHAR(salary * 12, '$999,999.99') ����
FROM employees;

-- TO_NUMBER: ���ڿ� -> ���� ����
SELECT 
    TO_NUMBER('$1,500,500.90', '$999,999,999.99')    
FROM dual;

-- TO_DATE: ��¥ ���¸� ���� ���ڿ� -> date 
SELECT 
    '2021-03-16 15:07',
    TO_DATE('2021-03-16 15:07', 'YYYY-MM-DD HH24:MI')
FROM dual;

/*
��¥ ����
-- Date +(-) Number : ��¥�� �ϼ��� ���ϰų� ���� -> Date
-- Date - Date : �� ��¥ ������ �ϼ�
-- Date + Number / 24 : ��¥�� �ð��� ���ϰų� �� ���� Number / 24�� ���ϰų� ����
*/
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI'),
    TO_CHAR(sysdate - 8, 'YYYY-MM-DD HH24:MI'), -- 8�� ��
    TO_CHAR(sysdate + 8, 'YYYY-MM-DD HH24:MI'), -- 8�� ��
    sysdate - TO_DATE('1999-12-31', 'YYYY-MM-DD'), -- 1999�� 12�� 31�� ���ķ� ��ĥ�� �����°�?
    TO_CHAR(sysdate + 12/24, 'YYYY-MM-DD HH24:MI') -- ���� �ð����κ��� 12�ð� ����
FROM dual;

-- NULL ����
--  NULL�� �����꿡 ���ԵǸ� NULL
--  NULL�� �� ó��������
SELECT first_name, 
    salary, 
    nvl(salary * commission_pct, 0) commission -- nvl: ù��° ���ڰ� null -> �ι�° ���ڰ��� ����Ѵ�
FROM employees;

-- nvl2: ù��° ���ڰ� not null�̸� �ι�° ����, null�̸� ����° ���ڸ� ���
SELECT first_name,
    salary,
    nvl2(commission_pct, salary * commission_pct, 0) commission 
FROM employees;

-- CASE Function
-- ���ʽ��� ����
-- AD���� ���� -> 20%, SA���� ���� 10%, IT���� ���� 8%, �������� 3%�� �����ϱ�� ����

SELECT first_name, job_id, SUBSTR(job_id, 1, 2) FROM employees; -- JOB_ID ���� Ȯ��

SELECT first_name, job_id, SUBSTR(job_id, 1, 2) ����, salary,
    CASE SUBSTR(job_id, 1, 2) 
        WHEN 'AD' THEN salary * 0.2 -- IF
        WHEN 'SA' THEN salary * 0.1 -- ELSE IF
        WHEN 'IT' THEN salary * 0.08
        ELSE salary * 0.03
    END bonus
FROM employees;

-- DECODE
SELECT first_name, job_id, SUBSTR(job_id, 1, 2) ����, salary,
    DECODE(SUBSTR(job_id, 1, 2),    --  ���� ��
        'AD', salary * 0.2,         -- IF: substr(job_id, 1, 2) = 'AD'
        'SA', salary * 0.1,
        'IT', salary * 0.08,
        salary * 0.03) bonus        --  ELSE
FROM employees;

---
- ��������

/*
������ �̸�, �μ�, ���� ����Ͻʽÿ�
 ���� �ڵ�� �����ϸ� ������ ���� �׷� �̸��� ����մϴ�
 �μ� �ڵ尡 10 ~ 30�̸�: 'A-GROUP'
 �μ� �ڵ尡 40 ~ 50�̸�: 'B-GROUP'
 �μ� �ڵ尡 60 ~ 100�̸� : 'C-GROUP'
 ������ �μ��� : 'REMAINDER'
*/
SELECT first_name, department_id, 
    CASE WHEN department_id >=10 AND department_id <= 30 THEN 'A-GROUP'
        WHEN department_id <= 50 THEN 'B-GROUP'
        WHEN department_id <= 100 THEN 'C-GROUP'
        ELSE 'REMAINDER'
    END team
FROM employees
ORDER BY team;

---------------------------------------------------------------------------
/*����1��
��ü������ ���� ������ ��ȸ�ϼ���. ������ �Ի���(hire_date)�� �ø�����(ASC)���� ���� ��
�Ӻ��� ����� �ǵ��� �ϼ���. �̸�(first_name last_name), ����(salary), ��ȭ��ȣ
(phone_number), �Ի���(hire_date) �����̰� ���̸���, �����ޡ�, ����ȭ��ȣ��, ���Ի��ϡ� �� �÷���
���� ��ü�� ������.*/

SELECT CONCAT(first_name, CONCAT(' ' ,last_name)) �̸�, salary ����, 
        phone_number ��ȭ��ȣ, hire_date �Ի���
FROM employees
ORDER BY hire_date;

---------------------------------------------------------------------------
/*����2��
����(jobs)���� �����̸�(job_title)�� �ְ����(max_salary)�� ������ ��������(DESC)�� ����
�ϼ���.*/

SELECT job_title �����̸�, max_salary �ְ����
FROM jobs
ORDER BY max_salary DESC;

---------------------------------------------------------------------------
/*����3��
��� �Ŵ����� �����Ǿ������� Ŀ�̼Ǻ����� ����, ������ 3000�ʰ��� ������ �̸�, �Ŵ���
���̵�, Ŀ�̼� ����, ���� �� ����ϼ���.
*/

SELECT CONCAT(first_name, CONCAT(' ' ,last_name)) �̸�, manager_id as "�Ŵ��� ���̵�", 
        commission_pct as "Ŀ�̼� ����", salary ����
FROM employees
WHERE manager_id is not null and commission_pct is null and salary > 3000;

---------------------------------------------------------------------------
/*����4��
�ְ����(max_salary)�� 10000 �̻��� ������ �̸�(job_title)�� �ְ����(max_salary)�� ��
�������(max_salary) ��������(DESC)�� �����Ͽ� ����ϼ���.*/
---------------------------------------------------------------------------

SELECT job_title �����̸�, max_salary �ְ����
FROM jobs
WHERE max_salary > 10000
ORDER BY max_salary DESC;

---------------------------------------------------------------------------
/*���� 5��
������ 14000 �̸� 10000 �̻��� ������ �̸�(first_name), ����, Ŀ�̼��ۼ�Ʈ �� ���޼�
(��������) ����ϼ���. �� Ŀ�̼��ۼ�Ʈ �� null �̸� 0 ���� ��Ÿ���ÿ�*/

SELECT first_name �̸�, salary ����, nvl(commission_pct, 0) as "Ŀ�̼� �ۼ�Ʈ"
FROM employees
WHERE salary >= 10000 AND salary < 14000
ORDER BY salary DESC;
---------------------------------------------------------------------------
/*���� 6��
�μ���ȣ�� 10, 90, 100 �� ������ �̸�, ����, �Ի���, �μ���ȣ�� ��Ÿ���ÿ�
�Ի����� 1977-12 �� ���� ǥ���Ͻÿ� */

SELECT CONCAT(first_name, CONCAT(' ' ,last_name)) �̸�, salary ����, 
        TO_CHAR(hire_date, 'YYYY-MM') �Ի���, department_id �μ���ȣ
FROM employees
WHERE department_id in (10, 90, 100);

---------------------------------------------------------------------------
/*���� 7��
�̸�(first_name)�� S �Ǵ� s �� ���� ������ �̸�, ������ ��Ÿ���ÿ�*/

SELECT CONCAT(first_name, CONCAT(' ' ,last_name)) �̸�, salary ����
FROM employees
WHERE LOWER(first_name) LIKE '%s%' ;

---------------------------------------------------------------------------
/*���� 8��
��ü �μ��� ����Ϸ��� �մϴ�. ������ �μ��̸��� �� ������� ����� ������.*/
SELECT *
FROM departments
ORDER BY LENGTH(department_name) DESC ;

---------------------------------------------------------------------------
/*���� 9��
��Ȯ���� ������, ���簡 ���� ������ ����Ǵ� ������� �����̸��� �빮�ڷ� ����ϰ�
�ø�����(ASC)���� ������ ������.*/

SELECT UPPER(country_name) �����̸�
FROM countries
ORDER BY country_name;

---------------------------------------------------------------------------
/*���� 10��
�Ի����� 03/12/31 �� ���� �Ի��� ������ �̸�, ����, ��ȭ ��ȣ, �Ի����� ����ϼ���
��ȭ��ȣ�� 545-343-3433 �� ���� ���·� ����Ͻÿ�.*/

SELECT CONCAT(first_name, CONCAT(' ' ,last_name)) �̸�, salary ����, 
      REPLACE(phone_number, '.', '-') ��ȭ��ȣ, hire_date �Ի���
FROM employees
WHERE hire_date < '03/12/31';

---------------------------------------------------------------------------

SELECT *
FROM employees;