
/* count of suppliejrs against their respective category of email accounts who have gmail and yahoo accounts eg: gmail/yahoo
category cnt 
gmail     6
yahoo     2
*/
select category , count(*) count
from 
(	
select 
	case 
		when sd.email like '%gmail.com' then 'gmail' 
		when sd.email like '%yahoo.com' then 'yahoo'
	end category
	from lms_suppliers_details sd 
) 
where category = 'gmail' or category = 'yahoo'
group by category;


select substr(
	'123456789@gmail.com',
	(instr('123456789@gmail.com','@',1,1))+1,
	
	(
	instr('123456789@gmail.com','.com',1,1) 
	-
	instr('123456789@gmail.com','@',1,1)
	-1)
) from dual;

/* count of suppliers against their respective category 
of email accounts categories should be  gmail/ yahoo/ others
category cnt 
gmail     6
yahoo     2
others    6 
*/

select category, count(*) count
from (
select case
    when sd.email like '%gmail.com' then 'gmail'
    when sd.email like '%yahoo.com' then 'yahoo'
    else 'others'
    end category
    from lms_suppliers_details sd
)
group by category
;

create table table1
(
col1 number
);

insert into table1(col1) values (1);
insert into table1(col1) values (null);
insert into table1(col1) values (3);
insert into table1(col1) values (2);
insert into table1(col1) values (4);

select * from table1
order by col1  asc nulls last;
drop table table1;

create table table1
(
col1 number,
col2 number
);

insert into table1(col1,col2) values (1,10);
insert into table1(col1,col2) values (1,20);
insert into table1(col1,col2) values (1,30);
insert into table1(col1,col2) values (null,10);
insert into table1(col1,col2) values (null,30);
insert into table1(col1,col2) values (null,20);
insert into table1(col1,col2) values (3,30);
insert into table1(col1,col2) values (3,20);
insert into table1(col1,col2) values (3,10);
select * from table1;

select * 
from table1
order by col1 asc nulls first,col2;
select * from table1 order by col1 desc nulls last ,col2 asc;

drop table table1;

create table first_table ( a number);
create table second_table ( a number);

insert into first_table(a) values (1);
insert into first_table(a) values (2);
insert into first_table(a) values (3);

insert into second_table(a) values (45);
insert into second_table(a) values (23);
insert into second_table(a) values (123);

select * from user_tables 
where lower(table_name) 
in ('first_table','second_table');

/* name of the members ordered on their names ascending */
select member_name
from lms_members
order by member_name;

/* list the book_name and issuance_date ,
 date_of_expected_return 
Such that the books that are to be returned 
at the earliest are seen at the top */

select bd.book_title,bi.date_issue,bi.date_returned
from lms_book_details bd
inner join 
lms_book_issue bi
on(bd.book_code=bi.book_code)
order by bi.date_returned;

/*  list all the members such
 that the oldest member (the very first member to my LMS) 
 of my LMS appears at the top
*/ 

select lm.member_name,lm.date_register
from lms_members lm
order by lm.date_register ;

/*  list all the members
	such that the longest duration of membership member
	(as of today)
    appears at the top and the member is active right now  */ 
select distinct member_name,date_register,date_expire ,round(sysdate-date_register)"duration days"
from lms_members
order by round(sysdate-date_register) desc;

/* provide the supplier name , their city , 
  no_of_books supplied
  based on the person who has supplied  
  most books comes at the top
  note : we would have suppliers 
  who have not supplied any books 
  at the bottom of the output
  and the count would be 0*/   
select sd.supplier_name,sd.address,count(bd.supplier_id) as "number of books"
from lms_suppliers_details sd
left join lms_book_details bd
on (sd.supplier_id = bd.supplier_id)
group by sd.supplier_name,sd.address
order by "number of books" desc;


/* provide the book codes and book names based on the least issued book comes at the top 
  note : we would have books who have not been issued at the top of the output */
select bd.book_code,bd.book_title,count(bi.book_code)"number of books issued"
from lms_book_details bd
left join lms_book_issue bi
on (bd.book_code = bi.book_code)
group by bd.book_code,bd.book_title
order by "number of books issued" ;
  
  /* provide the name of the member,total_fine based on the most fined member comes at the top
  note : we would have members who have not been issued books at the bottom of the output */
  
  select  lm.member_id,LM.MEMBER_NAME , bi.fine_range,fd.fine_amount*count(*) as "TOTAL FINE"  
  from lms_members lm
  LEFT join lms_book_issue bi
  on (bi.member_id = lm.member_id )
  LEFT join lms_fine_details fd
  on (bi.fine_range = fd.fine_range)
  group by lm.member_id ,LM.MEMBER_NAME, bi.fine_range,fd.fine_amount
  ORDER BY "TOTAL FINE" DESC NULLS LAST;














































