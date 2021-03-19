Skip to content
Search or jump to��

Pull requests
Issues
Marketplace
Explore
 
@xorud2592 
javaweb-bit
/
SQL
1
00
Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
SQL/03-dcl-and-dml.sql
@namsk
namsk ����� ����
Latest commit a22fb29 1 hour ago
 History
 1 contributor
83 lines (70 sloc)  3.02 KB
  
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
GRANT create session TO C##NAMSK;   --  C##NAMSK���� ���� ����(�α���) ������ �ο�

/* �α��� �ؼ� ������ ������ ������ ���ϴ�.
CREATE TABLE test(a NUMBER); -- ���� �����
*/
GRANT connect, resource TO C##NAMSK;    --  ���Ӱ� �ڿ� ���� ���� C##NAMSK���� �ο�

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
-- HR ������ employees ���̺��� ��ȸ ������ C##NAMSK���� �ο��ϰ� �ʹٸ�
GRANT SELECT ON hr.employees TO C##NAMSK;

-- C##NAMSK�� ����
SHOW USER;
SELECT * FROM hr.employees; --  hr.employees�� SELECT ������ �ο��޾����Ƿ� ���̺� ��ȸ ����
? 2021 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
