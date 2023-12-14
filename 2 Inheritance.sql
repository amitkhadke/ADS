create or replace type person as object(
fname varchar2(10), lname varchar2(10),
dob date,
member function FullName return varchar2, 
member function OnDate return date) 
not final;


create or replace type body person is
 member function FullName return varchar2 is
flname varchar2(100);
begin
flname:= self.fname||' '||self.lname;
return flname;
end FullName;
member function OnDate return date is
begin
return self.dob; end OnDate;
end;

create or replace type EmpObj under Person( job varchar2(18),
sal number (6),
da number(3),
doj date, member function Earn return number,
overriding member function OnDate return date)
Final;

create or replace type body EmpObj is
member function Earn return number is
amt number;
begin
amt := self.sal+ (self.sal * self.da/100);
return amt;
end Earn;
overriding member function OnDate return date is
begin
return self.doj; end OnDate;
end;

create table EmpRec (empid number, 
                    details EmpObj);
                    
Insert into EmpRec
values (1, EmpObj('donald', 'trump', '15-aug 1961', 'president', 
                    3000, 120, '26-jan-2016'));
                    
Insert into EmpRec values (2, EmpObj('vladimir', 'putin', '02-oct 1963', 'analyst',
                            2500, 140, '01-apr-2015'));
select empid, x.details. fullname() as fullname, x.details.OnDate() as doj, 
        x.details.dob as dob, x.details.earn() as earning
        
From emprec x; 
select empid, x.details. fullname() as fullname, x. details. OnDate() as doj, 
        x.details.dob as dob, x.details.sal, x.details.earn() as earning
from emprec x;