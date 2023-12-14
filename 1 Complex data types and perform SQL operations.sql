
CREATE TYPE nameType as object
    ( fname varchar(20)
    , lname varchar(20)
    )
    final
    
CREATE TYPE publisherType as object 
    ( pub_id varchar(20)
    , pub_name varchar(20)
    , branch varchar(20)
    )
    final
    
CREATE TABLE Author
    ( author_id varchar(10)
    , name nameType
    , phone_no varchar(20)
    , primary key(author_id)
    )
    
CREATE TABLE Book
    ( ISBN int 
    , Title varchar(30)
    , author_id varchar(10) 
    , category varchar(20)
    , publisher publisherType
    , keyword varchar(10)
    , price int
    , primary key(ISBN)
    , foreign key(author_id) references Author(author_id)
    )
    
CREATE TABLE Customer
    ( customer_id varchar(10)
    , name nameType
    , primary key(customer_id)
    )
    
CREATE TABLE Book_Sale
    ( phone varchar(15)
    , sale_id varchar(10) 
    , customer_id varchar(10)
    , ISBN int
    , primary key(sale_id)
    , foreign key (customer_id) references Customer(customer_id)
    , foreign key (ISBN) references Book(ISBN)
    )

insert into Author values('A1',new nameType('Yash','Chougale'),'9764121127');
insert into Author values('A2',new nameType('Aniket','Chougale'),'9764121128');
insert into Author values('A3',new nameType('Sanket','Ardalkar'),'9764121129');
insert into Author values('A4',new nameType('Prathamesh','Shelar'),'9764121130');

insert into Book values(1,'Tata Hill','A1','Edu',new publisherType('P1','Yash','CSE'),'Y',100);
insert into Book values(2,'Tata ','A2','Edu',new publisherType('P2','Aniket','CSE'),'A',500);
insert into Book values(3,'Tata P','A3','Edu',new publisherType('P3','Prathamesh','CSE'),'P',2000);

insert into Customer values('C1',new nameType('Yash','Chougale'));
insert into Customer values('C2',new nameType('Aniket','Chougale'));
insert into Customer values('C3',new nameType('Prathamesh','Shelar'));

insert into Book_Sale values('9764121127','S1','C1',1);
insert into Book_Sale values('9764121128','S2','C2',2);
insert into Book_Sale values('9764121129','S3','C3',3);

/* 1.	List all titles in “book” and include ISBN, author name 
(as combined from author.fname and author.lname). */
select Title,ISBN, concat(concat(author.name.fname ,' '), author.name.lname) as name
from Book inner join author on book.author_id = author.author_id;

/* 2.	List all customers who have purchased books published with ‘Tata MaGraw Hill’. */
select book.title, customer.customer_id, concat(concat(customer.name.fname ,' '), customer.name.lname) as name 
from customer inner join book_sale on customer.customer_id = book_sale.customer_id 
              inner join book on book.isbn = book_sale.isbn
              where book.publisher.pub_name like '%Yash%';

/* 3.	List customers (as combined from customer.fname and customer.lname) 
who have purchased books published in the UK or the US, as well as the title 
of the book they purchased and the name of its publisher and order by last name of customer. */

/* 4.	List the different (distinct) categories and how many books belong 
to each category, order alphabetically by category. */
select distinct(category), count(book.isbn)
from book 
group by category
order by category desc;

/* 5.	List the number of books sold that have been written 
by each author and group by author’s first name. */

with sale_data as (select distinct(author.author_id),count(book_sale.sale_id) as sale_count
from author inner join book on book.author_id = author.author_id
            inner join book_sale on book_sale.isbn = book.isbn
            group by author.author_id)
            
select concat(concat(author.name.fname ,' '), author.name.lname) as author_name, sale_count
from author inner join sale_data on author.author_id = sale_data.author_id          
order by author.name.fname desc;
            
