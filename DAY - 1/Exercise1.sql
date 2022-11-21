CREATE TABLE lms_members
(
MEMBER_ID NUMBER,
MEMBER_NAME VARCHAR(100),
CITY VARCHAR(100),
DATE_REGISTER DATE,
DATE_EXPIRE DATE,
MEMBERSHIP_STATUS VARCHAR(100));

--DROP TABLE lms_members;

SELECT * FROM lms_members;

alter table lms_members
add address VARCHAR(100) add contact number;

alter table lms_members
modify  address varchar2(3999);
--desc lms_members;
alter table lms_members_practice
modify MEMBER_ID VARCHAR2(100);
alter table lms_members
drop column contact;

alter table lms_members 
rename column address to member_address;

rename lms_members to lms_members_practice;
SELECT * FROM lms_members_practice;

insert into lms_members_practice(MEMBER_ID ,MEMBER_NAME,CITY ,DATE_REGISTER ,DATE_EXPIRE ,MEMBERSHIP_STATUS,member_address) values
('LM009','Nikit','Delhi',to_date('12-12-2012','dd-mm-yyyy'),to_date('12-12-2012','dd-mm-yyyy'),'Temporary','rajori road');

insert into lms_members_practice(MEMBER_ID ,MEMBER_NAME,CITY ,DATE_REGISTER ,DATE_EXPIRE ,MEMBERSHIP_STATUS,member_address) values
('LM020','Supriya','Delhi',to_date('12-12-2012','dd-mm-yyyy'),to_date('12-12-2012','dd-mm-yyyy'),'Temporary','uttam nagar');

insert into lms_members_practice(MEMBER_ID ,MEMBER_NAME,CITY ,DATE_REGISTER ,DATE_EXPIRE ,MEMBERSHIP_STATUS,member_address) values
('LM009','Gaurav','Delhi',to_date('12-06-2018','dd-mm-yyyy'),to_date('12-05-2020','dd-mm-yyyy'),'Temporary','nawada');

delete from lms_members_practice;
SELECT * FROM lms_members_practice;

update lms_members_practice
set member_address = 'karnataka';

--<case 1> rollback
select * from lms_members_practice;
insert into lms_members_practice(member_id,MEMBER_NAME,city,date_register,date_expire,membership_status,member_address)
values ('LM011','Gaurav','Delhi',TO_DATE('12-12-2012','dd-mm-yyyy'),TO_DATE('12-12-2012','dd-mm-yyyy'),'Temporary','rajori road');

select * from lms_members_practice;

rollback;
select * from lms_members_practice;

insert into lms_members_practice(member_id,MEMBER_NAME,city,date_register,date_expire,membership_status,member_address)
values ('LM012','Gauri','Delhi',TO_DATE('12-12-2012','dd-mm-yyyy'),TO_DATE('12-12-2012','dd-mm-yyyy'),'Temporary','uttam nagar');

commit;
rollback;
select * from lms_members_practice;

savepoint s1;

insert into lms_members_practice(member_id,MEMBER_NAME,city,date_register,date_expire,membership_status,member_address)
values ('LM013','Pratik','Delhi',TO_DATE('12-12-2012','dd-mm-yyyy'),TO_DATE('12-12-2012','dd-mm-yyyy'),'Temporary','uttam nagar');

savepoint s2;

insert into lms_members_practice(member_id,MEMBER_NAME,city,date_register,date_expire,membership_status,member_address)
values ('LM014','Deepak','Delhi',TO_DATE('12-12-2012','dd-mm-yyyy'),TO_DATE('12-12-2012','dd-mm-yyyy'),'Temporary','uttam nagar');

select * from lms_members_practice;

rollback to savepoint s2;

select * from lms_members_practice;






