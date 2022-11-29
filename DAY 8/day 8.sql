select * from lms_book_details;
select * from lms_book_issue;
select * from lms_suppliers_details;
select * from lms_fine_details;
select * from lms_members;
/* category of book ,
    total number of books under that category 
    such that the category has more than 2 books 
*/
select category,count(*)"Number of books"
from lms_book_details
group by category
having count(*) > 2;

/* book code and name of the book which has been issued atleast twice */ 
select bd.book_code,bd.book_title
from lms_book_details bd
inner join 
(select bi.book_code,count(*)
from lms_book_issue bi
group by bi.book_code
having count(*) >=2)cnt
on (cnt.book_code = bd.book_code);

/* book code and name of the book which has been issued atleast twice to a member*/
select distinct bd.book_code,bd.book_title
from lms_book_details bd
inner join
(select bi.member_id,bi.book_code, count(book_code)
from lms_members lm
inner join lms_book_issue bi
on (lm.member_id = bi.member_id)
group by bi.member_id,bi.book_code
having count(book_code) >=2) cnt
on (cnt.book_code=bd.book_code);

/* book codes and their issued counts */
select book_code, count(*)
from lms_book_issue
group by book_code;

/* book_code and name of the book which has been issued more than 4 times 
   and has more than 0 suppliers 
   (Note: Java how to program has 2 book codes because of different published date) 
*/

select bi.book_code,bd.book_title, count(*)
from lms_book_issue bi
inner join lms_book_details bd
on (bi.book_code = bd.book_code)
group by bi.book_code,bd.book_title
having count(*) > 4;

/* name of the book which has been issued more than 4 times and has more than 0 suppliers */
-- total number of books placed on given rack number 
-- such that edition of the book is atleast 3 -- ( done)
-- and it is supplied by a supplier who has a rediff / gmail account  -- ( done)
-- and the book is issued to the students who are permanent in status -- ( done )
select bd.rack_num,count(*)
from lms_book_details bd
inner join
(select distinct bd.book_code,bi.member_id,bd.book_title,bd.book_edition
from lms_book_details bd
inner join lms_book_issue bi
on(bd.book_code = bi.book_code)
inner join lms_suppliers_details sd
on (bd.supplier_id = sd.supplier_id) 
inner join lms_members lm
on(bi.member_id = lm.member_id)
where bd.book_edition >=3 and sd.email like '%gmail%' and membership_status='Permanent'
 )cnt
on(cnt.book_code = bd.book_code)
group by bd.rack_num
;

 -- total of number of all the books that have been issued to a member who stays in Delhi / Mumbai / Pune 
 -- and book that was issued has arrived later than 1st July 2000
 -- and supplied by a supplier who belongs to  Delhi / Mumbai / Pune / Chennai
 
 select  lm.member_name,lm.city,count(distinct bd.book_code) total
 from lms_book_issue bi
 inner join lms_members lm
 on (bi.member_id = lm.member_id)
 inner join lms_book_details bd
 on (bi.book_code = bd.book_code)
 inner join lms_suppliers_details sd
 on(bd.supplier_id = sd.supplier_id)
 where lower(lm.city) in ('delhi','mumbai','pune') and bd.date_arrival > '01-07-2000' 
 and lower(sd.address) in('delhi','mumbai','pune','chennai')
 group by lm.member_name,lm.city;
 
 -----assignment on set operations--------
 --provide the distinct list of all cities where members and suppliers reside
 select  upper(lm.city) from lms_members lm
 union
 select  upper(sd.address) from lms_suppliers_details sd;
 
 --provide the list of all cities where members and suppliers reside
 select  upper(lm.city) city from lms_members lm
 union all
 select  upper(sd.address) from lms_suppliers_details sd;
 
 --provide the distinct list of all return_date and returned_date for all book issuances
 select date_return from lms_book_issue
 union
 select date_returned from lms_book_issue;

--provide the member_names and suppliers_names together in a single column named "names_in_lms"
select lm.member_name names_in_lms from lms_members lm
union 
select sd.supplier_name names_in_lms from lms_suppliers_details sd;


--provide the list of all cities for members where there are no suppliers from that city
select lm.city from lms_members lm
minus
select sd.address from lms_suppliers_details sd;

--provide the list of all cities for suppliers where there are no members from that city
select sd.address from lms_suppliers_details sd
minus
select lm.city from lms_members lm;

--provide the list of all cities which are common across members and suppliers
select lm.city from lms_members lm
intersect
select sd.address from lms_suppliers_details sd;





















