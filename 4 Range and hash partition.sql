CREATE TABLE employees (
    id INTEGER,
    fname VARCHAR(30),
    lname VARCHAR(30),
    store_id INTEGER NOT NULL)
 
 PARTITION BY RANGE(id)
 ( PARTITION P0 VALUES LESS THAN (5),
    PARTITION P1 VALUES LESS THAN (10),
    PARTITION P2 VALUES LESS THAN (15),
   PARTITION P3 VALUES LESS THAN (MAXVALUE)); 
   
   
INSERT INTO employees(id,fname,lname,store_id)
VALUES('1','Manasi','katare','101');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('2','Aditi','Sahasrabudhe','102');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('3','Shreya','Jadhav','103');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('4','Deshna','Shah','104');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('5','Tanaya','Bhat','105');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('6','Vaishnavi','Pawar','106');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('7','Jyoti','Kamat','107');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('8','Amisha','kelkar','108');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('9','Alia','Bhatt','109');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('10','Deepika','Padukone','110');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('11','Shweta ','Thakur','111');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('12','Vidya','Bangale','112');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('13','Sneha','Kurlekar','113');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('14','Mira','Rajput','114');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('15','Priyanka','Chopra','115');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('16','Virat','Kolhi','116');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('17','Rohit','Sharma','117');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('18','Neil','Desai','118');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('19','Parth','Kumthekar','119');

INSERT INTO employees(id,fname,lname,store_id)
VALUES('20','Ronit','Vardhamane','120');

SELECT * FROM employees;

SELECT * FROM employees PARTITION (P0);

--1.Retrieve employee details from partition P1 and P2.
SELECT * FROM employees PARTITION(P1) UNION ALL SELECT * FROM employees PARTITION (P2);


--Retrieve employee details from partition P0 and P1 where fname begin with  S 
SELECT * FROM (
SELECT * FROM employees PARTITION(P0) UNION ALL SELECT * FROM employees PARTITION (P1)
)WHERE fname LIKE 'S%';


--3.Retrieve employee details from all partition p1, p2 and p3 and order by fname in ascending order.
SELECT * FROM (
SELECT * FROM employees PARTITION(P1) UNION ALL SELECT * FROM employees PARTITION (P2) UNION ALL SELECT * FROM employees PARTITION (P3)
)ORDER BY fname ASC;





DROP TABLE sales_hash;
CREATE TABLE sales_hash (
    salesman_id NUMBER(5),
    sales_name VARCHAR(30),
    sales_amount  number(10),
    week_no  NUMBER(2))
PARTITION BY HASH(salesman_id)
(PARTITION p0,PARTITION p1,PARTITION p2,PARTITION p3);

INSERT INTO sales_hash (salesman_id,sales_name,sales_amount,week_no)
VALUES(1,'Ronit',200,1);

INSERT INTO sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(2,'Aditi',220,2);

INSERT INTO sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(3,'Manasi',270,3);

INSERT INTO  sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(4,'Shreya',300,4);

INSERT INTO  sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(5,'Jyoti',250,5);

INSERT INTO  sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(6,'Vaishnavi',180,6);

INSERT INTO  sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(7,'Tanaya',360,7);

INSERT INTO  sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(8,'Deshna',500,8);

INSERT INTO  sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(9,'Neil',110,9);

INSERT INTO  sales_hash(salesman_id,sales_name,sales_amount,week_no)
VALUES(10,'Parth',700,10);
