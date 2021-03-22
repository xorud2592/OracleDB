/*
����� ����
	CREATE USER C##NAMSK IDENTIFIED BY 1234;
	- Oracle: ����� ���� -> ���� �̸��� SCHEMA�� ���� ����
����� ����
	DROP USER C##NAMSK
	DROP USER C##NAMSK CASCADE  - ����� ��ü�� ��� ����
������ ������ ������ �ƹ� �ϵ� ���ؿ�
*/

-- system���� ����
-- ����� ���� Ȯ��
-- USER_USERS: ���� ����� ���� ����
-- ALL_USERS: DB�� ��� ����� ����
-- DBA_USERS: ��� ������� �� ����(DBA Only)

-- ���� ����� Ȯ��
SELECT * FROM USER_USERS;
--  ��ü ����� Ȯ��
SELECT * FROM ALL_USERS;

-- �α��� ���� �ο�
CREATE USER C##NAMSK IDENTIFIED BY 1234;   -- �α����� �� ���� ����
-- ������ ������ �ο��ؾ� �Ѵ٤�
GRANT create session TO C##NAMSK;   --  C##NAMSK���� ���� ����(�α���) ������ �ο�

/* �α��� �ؼ� ������ ������ ������ ���ϴ�.
CREATE TABLE test(a NUMBER); -- ���� �����
*/
GRANT connect, resource TO C##NAMSK;    --  ���Ӱ� �ڿ� ���� ���� C##NAMSK���� �ο�
-- �Ϲ� �����ͺ��̽� ����ڷ� Ȱ�� ����

/* �ٽ� �α��� �ؼ� ������ ������ ������ ���ϴ�.
CREATE TABLE test(a NUMBER); -- ���̺��� ����
SELECT * FROM tab;
DESC test;
INSERT INTO test
VALUES(10);
-- ���̺� �����̽� 'USERS'�� ���� ������ �����ϴ�.
*/

/*
���� ����
Oracle 12����
    - �Ϲ� ���� �����ϱ� ���� C## ���ξ�
    - ���� �����Ͱ� ����� ���̺� �����̽� ������ ��� �Ѵ� - USERS ���̺� �����̽��� ������ ����
*/
/* C## ���� ������ �����ϴ� ��� - �� */
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER NAMSK IDENTIFIED BY 1234;
/* ����� ������ ���� ���̺� �����̽� �ο� */
ALTER USER C##NAMSK DEFAULT TABLESPACE USERS    -- C##NAMSK ������� ���� ������ USERS�� ����
    QUOTA unlimited ON USERS;   --  ���� ���� �ѵ��� �������� �ο�

-- ROLE�� ����
DROP ROLE dbuser;
CREATE ROLE dbuser; --  dbuser ������ ����� �������� ������ ��Ƶд�
GRANT create session TO dbuser;   --  dbuser ���ҿ� ������ �� �ִ� ������ �ο�
GRANT resource TO dbuser;       --  dbuser ���ҿ� �ڿ� ���� ������ �ο�

-- ROLE�� GRANT �ϸ� ���ο� �ִ� ���� Privilege(����)�� ��� �ο�
GRANT dbuser TO namsk;      --  namsk ����ڿ��� dbuser ������ �ο�
-- ������ ȸ�� REVOKE 
REVOKE dbuser FROM namsk;   --  namsk ����ڷκ��� dbuser ������ ȸ��

-- ���� ����
DROP USER namsk CASCADE;

-- ���� ����ڿ��� �ο��� ROLE Ȯ��
-- ����� �������� �α���
show user;
SELECT * FROM user_role_privs;

-- CONNECT ���ҿ��� � ������ ���ԵǾ� �ִ°�?
DESC role_sys_privs;
SELECT * FROM role_sys_privs WHERE role='CONNECT';  -- CONNECT���� �����ϰ� �ִ� ����
SELECT * FROM role_sys_privs WHERE role='RESOURCE';

SHOW USER;
-- System �������� ����
-- HR ������ employees ���̺��� ��ȸ ������ C##NAMSK���� �ο��ϰ� �ʹٸ�(system)
GRANT SELECT ON hr.employees TO C##NAMSK;   --  ������ �ο�
REVOKE SELECT ON hr.employees FROM C##NAMSK;    -- ������ ȸ��

-- C##NAMSK�� ����
SHOW USER;
SELECT * FROM hr.employees; --  hr.employees�� SELECT ������ �ο��޾����Ƿ� ���̺� ��ȸ ����

----------
-- DDL
----------

-- ���� ���� table Ȯ��
SELECT * FROM tab;
-- ���̺��� ���� Ȯ��
DESC test;

-- ���̺� ����
DROP TABLE test;
SELECT * FROM tab;
--  ������
PURGE RECYCLEBIN;   -- ������ ���̺��� �����뿡 ����

SELECT * FROM tab;

-- CREATE TABLE
CREATE TABLE book ( -- �÷� ��
    book_id NUMBER(5),  --  5�ڸ� ����
    title VARCHAR2(50), --  50���� ��������
    author VARCHAR2(10),    -- 10���� �������ڿ�
    pub_date DATE DEFAULT SYSDATE   -- �⺻���� ����ð�
);
DESC book;

-- ���������� Ȱ���� ���̺� ����
-- hr.employees ���̺��� ������� �Ϻ� �����͸� ����
--  �� ���̺�
SELECT * FROM hr.employees WHERE job_id like 'IT_%';
CREATE TABLE it_emps AS (
    SELECT * FROM hr.employees WHERE job_id like 'IT_%'
);

SELECT * FROM it_emps;
CREATE TABLE emp_summary AS (
    SELECT employee_id, 
        first_name || ' ' || last_name full_name,
        hire_date, salary
    FROM hr.employees
);
DESC emp_summary;
SELECT * FROM emp_summary;

-- author ���̺� 
DESC book;
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL, -- NULL�� �� ����
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id) -- author_id �÷��� PK��
);
DESC author;

-- book���̺� author ���̺� ������ ����
-- book ���̺��� author �÷��� ����: DROP COLUMN
ALTER TABLE book
DROP COLUMN author;
DESC book;

-- author���̺� ������ ���� author_id �÷��� book�� �߰�
ALTER TABLE book
ADD (author_id NUMBER(10));
DESC book;

-- book ���̺��� PK�� ����� book_id�� NUMBER(10)���� ����
ALTER TABLE book
MODIFY (book_id NUMBER(10));
DESC book;

-- ���������� �߰�: ADD CONSTRAINT
-- book ���̺��� book_id�� PRIMARY KEY �������� �ο�
ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY(book_id);
DESC book;

-- FOREIGN KEY �߰�
-- book ���̺��� author_id�� author�� author_id�� ����
ALTER TABLE book
ADD CONSTRAINT
    fk_author_id FOREIGN KEY (author_id)
        REFERENCES author(author_id);
DESC book;

-- COMMENT
COMMENT ON TABLE book IS 'Book Information';
COMMENT ON TABLE author IS 'Author Information';

-- ���̺� Ŀ��Ʈ Ȯ��
SELECT * FROM user_tab_comments;
SELECT comments FROM user_tab_comments 
WHERE table_name='BOOK';

--  Data Dictionary
-- Oracle�� ���ο��� �߻��ϴ� ��� ���θ� Data Dictionary�� ��Ƶΰ� �ִ�
--  �������� USER_(�Ϲ� �����), ALL_(��ü �����), DBA_(������ ����) ���� ������ ������
-- ��� ��ųʸ� Ȯ��
SHOW user;
SELECT * FROM dictionary;

-- DBA_ ��ųʸ� Ȯ��
-- dba�� �α��� �ʿ� as sysdba