select * from lms_book_issue;
select * from lms_book_details;
select * from lms_fine_details;
select * from lms_members;
select * from lms_suppliers_details;

/* Name of the members who have issued a book from the publication "Prentice Hall" */
select distinct lm.member_name
from lms_members lm
inner join lms_book_issue bi
on(lm.member_id= bi.member_id)
where bi.book_code in (select bd.book_code
from lms_book_details bd
inner join lms_book_issue bi
on(bd.book_code = bi.book_code)
where bd.publication = 'Prentice Hall');

/* Name of the members who have issued a book and such that book supplier belongs to PUNE/MUMBAI/DELHI*/

select distinct lm.member_name
from lms_members lm
inner join lms_book_issue bi
on(lm.member_id=bi.member_id)
where bi.book_code in(select distinct bd.book_code
from lms_book_details bd
inner join lms_suppliers_details sd
on(bd.supplier_id=sd.supplier_id)
where sd.address in ('CHENNAI','TRIVANDRUM'));

/* Name of the members who have issued a book later than 01-01-2000*/
 select distinct DATE_ISSUE, lm.member_name
from lms_members lm
inner join lms_book_issue bi
on(lm.member_id=bi.member_id)
where bi.date_issue >'02-04-2014';

 /* Name of the book , edition , publication that have been issued to members
who have enrolled after 01-01-1999*/
select book_title,book_edition,publication from
lms_book_details 
inner join lms_book_issue 
on(lms_book_details.book_code=lms_book_issue.book_code)
inner join lms_members on(lms_members.member_id=lms_book_issue.member_id)
where lms_members.date_register > '12-07-18';

/* Name of the book , edition , publication that have never been issued  */
select book_title,book_edition,publication
from lms_book_details bd
left join lms_book_issue bi
on(bd.book_code=bi.book_code)
where bi.date_issue is null;

/* name of the supplier who has not supplied any book 
and that supplier lives in PUNE/MUMBAI/DELHI*/
select sd.supplier_name
from lms_suppliers_details sd
left join lms_book_details bd
on(sd.supplier_id = bd.supplier_id)
where bd.supplier_id is null
and sd.address in ('PUNE','DELHI','MUMBAI');

/* name of the member who has issued a book which is not placed on any rack*/
select * from
lms_members lm
inner join lms_book_issue bi
on(lm.member_id = bi.member_id)
inner join lms_book_details bd
on(bd.book_code = bi.book_code)
where bd.rack_num is null;

/* name of the member , status of his membership who have issued a book and never paid a fine  */
select distinct lm.member_name,lm.membership_status
from lms_members lm
inner join lms_book_issue bi
on(lm.member_id=bi.member_id)
where bi.fine_range is null;

/* name of the member , status of his membership who have issued a book and paid atleast fine more than 74 rs*/
select distinct lm.member_name,lm.membership_status
from lms_members lm
inner join lms_book_issue bi
on(lm.member_id = bi.member_id)
inner join lms_fine_details fd
on(fd.fine_range = bi.fine_range)
where fd.fine_amount > 74 ;

/* name of the member who has issued a book which is not placed on any rack*/--rakesh wali query
select C.member_name from lms_book_issue A
inner join lms_book_details B 
on(A.Book_code = B.Book_code and B.Rack_num is null) 
left join lms_members C 
on (A.member_id = C.member_id);



select C.member_name from (select A.member_id from lms_book_issue A 
inner join lms_book_details B
on(A.Book_code = B.Book_code and B.Rack_num is null)) D
left join lms_members C
on (D.member_id = C.member_id);


/* name of the member , status of his membership who have issued a book 
and paid atleast fine more than 74 rs 
and the supplier has a gmail account */
select distinct lm.member_name,lm.membership_status
from lms_members lm
inner join lms_book_issue bi
on(lm.member_id = bi.member_id)
inner join lms_fine_details fd
on(fd.fine_range = bi.fine_range)
where fd.fine_amount > 74 and bi.book_code 
in(select distinct bd.book_code
from lms_suppliers_details sd
inner join lms_book_details bd
on(sd.supplier_id = bd.supplier_id)
where email like '%gmail%');

select distinct bd.book_code
from lms_suppliers_details sd
inner join lms_book_details bd
on(sd.supplier_id = bd.supplier_id)
where email like '%gmail%'
;

/*name of the book , publication , date of publication along with supplier name
and his contact number which may or may not have a supplier*/


--Rakesh
select A.member_name, A.membership_status 
from lms_book_issue B 
inner join lms_book_details C 
on (B.book_code = C.book_code and B.fine_amount > 74)
inner join lms_suppliers_details D
on (C.supplier_id = D.supplier_id and D.email is not null)
left join lms_members A on (B.member_id = A.member_id);



/* name of the book , publication , date of publication along with 
supplier name and his contact number 
Note : books that have no suppliers should not be displayed*/
select bd.book_title,bd.publish_date,bd.publication,sd.supplier_name,sd.contact
from lms_book_details bd
left join lms_suppliers_details sd
on(bd.supplier_id = sd.supplier_id)
where bd.supplier_id is not null;


/*name of the book , publication , date of publication along with supplier name 
and his contact number which may or may not have a supplier*/
select bd.book_title,bd.publish_date,bd.publication,sd.supplier_name,sd.contact
from lms_book_details bd
left join lms_suppliers_details sd
on(bd.supplier_id = sd.supplier_id);