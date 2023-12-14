

CREATE TABLE customer (
    cus_code INTEGER,      
    cus_lname VARCHAR2(10),                  
    cus_fname VARCHAR2(10),                    
    cus_initial VARCHAR2(1),                     
    cus_areacode INTEGER,                     
    cus_phone INTEGER,                     
    cus_balance NUMBER(10,2),
    PRIMARY KEY(cus_code)
);  

--i)	Create sequence on cus_code
CREATE SEQUENCE CUS_CODE_SEQ START WITH 10007 NOCACHE;

--ii)	Display user sequences
SELECT * FROM USER_SEQUENCES;

--iii)	Insert values into customer using created sequence
INSERT INTO CUSTOMER VALUES(CUS_CODE_SEQ.NEXTVAL, 'Connery','Sean', NULL, '615', '8982008111', 1000.00);
INSERT INTO CUSTOMER VALUES(CUS_CODE_SEQ.NEXTVAL, 'Norris','Francisco', NULL, '616', '8982009112', 1100.00);
INSERT INTO CUSTOMER VALUES(CUS_CODE_SEQ.NEXTVAL, 'Ortiz','Harold ', NULL, '617', '8992008113', 600.00);
INSERT INTO CUSTOMER VALUES(CUS_CODE_SEQ.NEXTVAL, 'Jimenez','Amy ', NULL, '618', '8982010114', 1100.00);
INSERT INTO CUSTOMER VALUES(CUS_CODE_SEQ.NEXTVAL, 'Bailey','Rita  ', NULL, '619', '8982011115', 1800.00);

--iv)	Display customer records
SELECT * FROM customer;

--STUDENT REPORT TABLE
CREATE TABLE student_report (
    tid    NUMBER(4),  
    name   VARCHAR2(30),                       
    subj1  NUMBER(2),          
    subj2  NUMBER(2),          
    subj3  NUMBER(2),          
    total  NUMBER(3),               
    per    NUMBER(3),
    PRIMARY KEY(tid),
    CHECK( subj1>=0 AND subj1 <= 20),
    CHECK( subj2>=0 AND subj2 <= 20),
    CHECK( subj3>=0 AND subj3 <= 20)
);

--CREATE OR REPLACE PROCEDURE STUDENT_REPORT_CHECK_PROCEDURE
--AS
--BEGIN 
--    UPDATE student_report SET total = subj1+subj2+subj3;
--    UPDATE student_report SET per = ((subj1+subj2+subj3)/60)*100;
--END;

CREATE OR REPLACE TRIGGER TRG_CHECK_REPORT 
BEFORE INSERT OR UPDATE ON student_report
FOR EACH ROW
DECLARE 
BEGIN
    :new.total := :new.subj1 + :new.subj2 + :new.subj3;
    :new.per := ((:new.subj1 + :new.subj2 + :new.subj3)/60)*100;
END;

insert into student_report values(1, 'Rick Novak', 13, 11, 15, 0, 0);
insert into student_report values(2, 'Susan Connor', 13, 19, 18, 0, 0);
insert into student_report values(3, 'Margaret Adelman', 18, 12, 16, 0, 0);
insert into student_report values(4, 'Ronald Barr', 14, 9, 14, 0, 0);
insert into student_report values(5, 'Marie Broadbet', 0, 11, 12, 0, 0);
insert into student_report values(6, 'Roger Lum', 12, 12, 17, 0, 0);
insert into student_report values(7, 'Kevin Li', 13, 13, 13, 0, 0);
insert into student_report values(8, 'Jeff Johnson', 15, 15, 15, 0, 0);
insert into student_report values(9, 'Melvin Forbis', 19, 18, 18, 0, 0);
insert into student_report values(10, 'Broman Gray', 19, 20, 20, 0, 0);

select * from student_report;
--exec STUDENT_REPORT_CHECK_PROCEDURE;
--select * from student_report;
--DROP PROCEDURE STUDENT_REPORT_CHECK_PROCEDURE;
    
    
--COURSE TABLE 
CREATE TABLE course (
    course_num INTEGER,          
    course_name VARCHAR(50),
    dept_name VARCHAR(15),                 
    credits INTEGER,
    PRIMARY KEY(course_num)
);

INSERT INTO course VALUES(1001, 'Math 1', 'BSH', 3);
INSERT INTO course VALUES(1002, 'Math 2', 'BSH', 3);
INSERT INTO course VALUES(1061, 'Compiler Construction Theory', 'CSE', 3);
INSERT INTO course VALUES(1071, 'Advanced Database System Theory', 'CSE', 3);
INSERT INTO course VALUES(1072, 'Distributed System Theory', 'CSE', 3);
INSERT INTO course VALUES(1073, 'Unix Operating System Theory', 'CSE', 3);
INSERT INTO course VALUES(1161, 'Compiler Construction Lab', 'CSE', 3);
INSERT INTO course VALUES(1171, 'Advanced Database System Lab', 'CSE', 1);
INSERT INTO course VALUES(1172, 'Distributed System Lab', 'CSE', 1);
INSERT INTO course VALUES(1173, 'Unix Operating System Lab', 'CSE', 1);
select * from course;

--i)	Write a procedure which includes cursors: Find course_name and credits where course name starts with  C 
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE LAB5_Q2_PROC_1
IS
C_NAME VARCHAR(50);
C_CREDIT INTEGER;
CURSOR CUR IS 
    SELECT course_name, credits 
    FROM course
    WHERE course_name LIKE 'C%';
BEGIN
    DBMS_OUTPUT.PUT_LINE(' Course Name                        Credit');
    DBMS_OUTPUT.PUT_LINE('=============================================');
    OPEN CUR;
    LOOP
        FETCH CUR INTO C_NAME, C_CREDIT;
        EXIT WHEN CUR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(' '||C_NAME||'            '||C_CREDIT);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('=============================================');
    DBMS_OUTPUT.PUT_LINE('TOTAL COURSES -> '||CUR%ROWCOUNT);
    CLOSE CUR;
END;

EXEC LAB5_Q2_PROC_1;

--ii)	Write a procedure which includes cursors: Find course names from  CSE  department
CREATE OR REPLACE PROCEDURE LAB5_Q2_PROC_2
IS
C_NAME VARCHAR(50);
CURSOR CUR IS 
    SELECT course_namE
    FROM course
    WHERE dept_name = 'CSE';
BEGIN
    DBMS_OUTPUT.PUT_LINE(' CSE Course Name');
    DBMS_OUTPUT.PUT_LINE('===================================');
    OPEN CUR;
    LOOP
        FETCH CUR INTO C_NAME;
        EXIT WHEN CUR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(' '||C_NAME);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('====================================');
    DBMS_OUTPUT.PUT_LINE('TOTAL COURSES -> '||CUR%ROWCOUNT);
    CLOSE CUR;
END;

EXEC LAB5_Q2_PROC_2;