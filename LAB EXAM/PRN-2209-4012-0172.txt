create table dept(
deptno number(2,0),
dname  varchar2(14),
loc    varchar2(13),
constraint pk_dept primary key (deptno
));

create table emp(
empno    number(4,0),
ename    varchar2(10),
job      varchar2(9),
mgr      number(4,0),
hiredate date,
sal      number(7,2),
comm     number(7,2),
deptno   number(2,0),
constraint pk_emp primary key (empno),
constraint fk_deptno foreign key (deptno) references dept (deptno)
);

insert into dept
values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept
values(20, 'RESEARCH', 'DALLAS');
insert into dept
values(30, 'SALES', 'CHICAGO');
insert into dept
values(40, 'OPERATIONS', 'BOSTON');

insert into emp
values(
7839, 'KING', 'PRESIDENT', null,
to_date('17-11-1981','dd-mm-yyyy'),
5000, null, 10
);
insert into emp
values(
7698, 'BLAKE', 'MANAGER', 7839,
to_date('1-5-1981','dd-mm-yyyy'),
2850, null, 30
);
insert into emp
values(
7782, 'CLARK', 'MANAGER', 7839,
to_date('9-6-1981','dd-mm-yyyy'),
2450, null, 10
);
insert into emp
values(
7566, 'JONES', 'MANAGER', 7839,
to_date('2-4-1981','dd-mm-yyyy'),
2975, null, 20
);
insert into emp
values(
7788, 'SCOTT', 'ANALYST', 7566,
to_date('13-JUL-87','dd-mm-rr') - 85,
3000, null, 20
);
insert into emp
values(
7902, 'FORD', 'ANALYST', 7566,
to_date('3-12-1981','dd-mm-yyyy'),
3000, null, 20
);
insert into emp
values(
7369, 'SMITH', 'CLERK', 7902,
to_date('17-12-1980','dd-mm-yyyy'),
800, null, 20
);
insert into emp
values(
7499, 'ALLEN', 'SALESMAN', 7698,
to_date('20-2-1981','dd-mm-yyyy'),
1600, 300, 30
);
insert into emp
values(
7521, 'WARD', 'SALESMAN', 7698,
to_date('22-2-1981','dd-mm-yyyy'),
1250, 500, 30
);
insert into emp
values(
7654, 'MARTIN', 'SALESMAN', 7698,
to_date('28-9-1981','dd-mm-yyyy'),
1250, 1400, 30
);
insert into emp
values(
7844, 'TURNER', 'SALESMAN', 7698,
to_date('8-9-1981','dd-mm-yyyy'),
1500, 0, 30
);
insert into emp
values(
7876, 'ADAMS', 'CLERK', 7788,
to_date('13-JUL-87', 'dd-mm-rr') - 51,
1100, null, 20
);
insert into emp
values(
7900, 'JAMES', 'CLERK', 7698,
to_date('3-12-1981','dd-mm-yyyy'),
950, null, 30
);
insert into emp
values(
7934, 'MILLER', 'CLERK', 7782,
to_date('23-1-1982','dd-mm-yyyy'),
1300, null, 10
);

SELECT * FROM emp;
SELECT * FROM DEPT;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

--==================================================================================
--Q1)1)ANSWER
SELECT emp.ENAME,emp.SAL,emp.HIREDATE,emp.DEPTNO,DEPT.DNAME
FROM emp
INNER JOIN DEPT
ON (EMP.DEPTNO = DEPT.DEPTNO);

--Q1)2)ANSWER
SELECT EMP.EMPNO,EMP.ENAME,EMP.JOB,EMP.SAL,DEPT.DNAME
FROM EMP
INNER JOIN DEPT
ON (EMP.DEPTNO = DEPT.DEPTNO)
WHERE EMP.JOB ='CLERK' OR EMP.JOB ='SALESMAN' ;


--Q1)3)ANSWER
SELECT EMP.EMPNO,EMP.ENAME,EMP.SAL
FROM EMP
WHERE EMP.ENAME LIKE '__L%';

--Q1)4)ANSWER
SELECT * FROM emp
WHERE HIREDATE > '31-12-1981';

--Q1)5)ANSWER
SELECT * FROM EMP
WHERE SAL > 3000 AND SAL < 5000;

--======================================================================================
--Q2)
--1)WRITE A QUERY TO GET THE EMP NAME ALONG WITH MANAGER NAME WHOSE NAME CONTAINS
--THIRD LETTER AS 'A'
--THERE IS NO MANAGER TABLE IN GIVEN DATA
--ANSWER
SELECT EMP.ENAME,EMP.MGR
FROM EMP
WHERE EMP.ENAME LIKE '__A%';

--Q2)2) ANSWER
SELECT DEPT.DNAME,DEPT.DEPTNO,EMP.ENAME
FROM EMP
INNER JOIN DEPT
ON (EMP.DEPTNO = DEPT.DEPTNO)
ORDER BY DEPT.DEPTNO , EMP.ENAME;

--Q2)3) ANSWER
SELECT DEPT.DNAME,COUNT(*)"NO OF EMPLOYEE"
FROM EMP
INNER JOIN DEPT
ON (EMP.DEPTNO = DEPT.DEPTNO)
GROUP BY DEPT.DNAME;

--Q2)4) ANSWER
SELECT ENAME,((SAL)*12)ANNUAL_SALARY
FROM EMP
ORDER BY ANNUAL_SALARY DESC;

-==========================================================================================
--Q3)ANSWER

CREATE OR REPLACE FUNCTION TOTAL_SALARY_DEPARTMENTWISE(DEPT_ID NUMBER) RETURN NUMBER AS
    TOTAL_SAL NUMBER;
BEGIN
    SELECT SUM(SAL) INTO TOTAL_SAL FROM  EMP GROUP BY DEPTNO HAVING DEPTNO = DEPT_ID;
    IF TOTAL_SAL IS NULL THEN
        TOTAL_SAL := 0;
    END IF;
    RETURN TOTAL_SAL;
END;


DECLARE
DEPTID NUMBER;
TOTAL_SUM NUMBER;
begin
    DEPTID:=10;
    TOTAL_SUM:=TOTAL_SALARY_DEPARTMENTWISE(DEPTID);
    DBMS_OUTPUT.PUT_LINE('TOTAL SALARY OF DEPARTMENT '||DEPTID||' IS '||TOTAL_SUM*12);
END;

--=========================================================================================
--Q4)ANSWER
CREATE OR REPLACE TRIGGER EMP_SAL_TRIGGER 
AFTER INSERT OR UPDATE OR DELETE ON EMP FOR EACH ROW
BEGIN
IF UPDATING THEN
DBMS_OUTPUT.PUT_LINE('OLD SALARY '||:OLD.SAL);
DBMS_OUTPUT.PUT_LINE('NEW SALARY '||:NEW.SAL);
DBMS_OUTPUT.PUT_LINE('DIFFERENCE BETWEEN OLD AND NEW SALARY IS '||(:OLD.SAL-:NEW.SAL));
END IF;
END;

UPDATE EMP SET SAL = 1000 WHERE EMPNO = 7369;

--=========================================================================================

