drop table Station cascade constraints;
drop table Train cascade constraints;
drop table Train_class cascade constraints;
drop table Passenger cascade constraints;
drop table Passenger_ticket cascade constraints;
drop table Train_status cascade constraints;
drop table Reservation_status cascade constraints;
drop table Waiting_list cascade constraints;

----------------------------Tables------------------------------------------


create table Station(
station_id varchar(10) not null,
station_name varchar(25)
);

alter table Station add constraint station_id primary key(station_id);


create table Train(
train_id int not null,
train_name varchar(20) not null,
source_stn varchar(30),
destination_stn varchar(30),
source_id varchar(10),
destination_id varchar(10),
primary key(train_id),
foreign key(source_id) references Station(station_id) on delete cascade,
foreign key(destination_id) references Station(station_id) on delete cascade
);



create table Train_class(
train_id int not null,
train_name varchar(20),
fare_class1 int not null,
seat_class1 int not null,
fare_class2 int not null,
seat_class2 int not null,
fare_class3 int not null,
seat_class3 int not null,
primary key(train_id)
);


create table Passenger(
seat_id int not null,
slno int not null,
passenger_name varchar(50) not null,
age int not null,
gender varchar(8) not null,
train_id int not null,
foreign key(train_id) references Train(train_id) on delete cascade,
primary key(seat_id,slno)
);


create table Passenger_ticket(
seat_id int not null,
source_id varchar(8) ,
destination_id varchar(8),
ticket_price number(8),
reservation_status char(2) not null,
train_id int not null,
available_date date,
foreign key(train_id) references Train(train_id) on delete cascade,
primary key(seat_id)
);


create table Train_status(
train_id int not null,
available_date varchar(20) not null,
total_seats int,
reserved_seats int,
primary key(train_id)
);



create table Reservation_status(
train_id int not null,
seat_id int not null,
reserved char(2) CHECK (reserved in('y','n')),
customer_name varchar(50),
foreign key(train_id) references Train_status(train_id) on delete cascade
);


create table Waiting_list(
slno int not null,
customer_name varchar(50),
train_id int not null,
primary key(customer_name),
foreign key(train_id) references Train_status(train_id) on delete cascade
);



-----------------------------------Inserting Data into Tables-------------------------------------------------- 

insert into Station(station_id,station_name) values('B1','Bogra Station');
insert into Station(station_id,station_name) values('Dh1','Dhaka Station');
insert into Station(station_id,station_name) values('Raj1','Rajshahi Station');
insert into Station(station_id,station_name) values('Kh1','Khulna Station');

insert into Train (train_id,train_name,source_stn,destination_stn,source_id,destination_id) values(01,'Sundarban','Khulna','Dhaka','Kh1','Dh1');
insert into Train (train_id,train_name,source_stn,destination_stn,source_id,destination_id) values(02,'Chitra','Bogra','Dhaka','B1','Dh1');
insert into Train (train_id,train_name,source_stn,destination_stn,source_id,destination_id) values(03,'Kornofuli','Rajshahi','Dhaka','Raj1','Dh1');
insert into Train (train_id,train_name,source_stn,destination_stn,source_id,destination_id) values(04,'Jomuna','Khulna','Bogra','Kh1','B1');
insert into Train (train_id,train_name,source_stn,destination_stn,source_id,destination_id) values(05,'Tista','Rajshahi','Bogra','Raj1','B1');


insert into Train_class(train_id,train_name,fare_class1,seat_class1,fare_class2,seat_class2,fare_class3,seat_class3)values
(01,'Sundarban',1,30,2,20,3,40);
insert into Train_class(train_id,train_name,fare_class1,seat_class1,fare_class2,seat_class2,fare_class3,seat_class3)values
(02,'Chitra',01,40,02,30,03,40);
insert into Train_class(train_id,train_name,fare_class1,seat_class1,fare_class2,seat_class2,fare_class3,seat_class3)values
(03,'Kornofuli',1,30,2,10,3,40);
insert into Train_class(train_id,train_name,fare_class1,seat_class1,fare_class2,seat_class2,fare_class3,seat_class3)values
(04,'Jomuna',001,30,002,20,003,40);
insert into Train_class(train_id,train_name,fare_class1,seat_class1,fare_class2,seat_class2,fare_class3,seat_class3)values
(05,'Tista',1,30,2,20,3,40);

insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(011,1,'poli',20,'female',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(012,2,'ratul',30,'male',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(021,1,'raja',40,'male',02);
insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(022,2,'ratan',45,'male',02);
insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(013,3,'oliullah',56,'male',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(014,4,'omar',20,'male',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(015,5,'ibrahim',25,'male',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(031,1,'akashi',33,'female',03);
insert into Passenger(seat_id,slno,passenger_name,age,gender,train_id) values
(041,1,'korobi',20,'female',04);


insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,train_id,available_date)values
(011,'Kh1','Dh1',500,'y',01,'26-jAN-2017');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,train_id,available_date)values
(012,'Kh1','Dh1',500,'y',01,'10-MAR-2017');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,train_id,available_date)values
(021,'B1','Dh1',900,'y',02,null);
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,train_id,available_date)values
(022,'B1','Dh1',900,'y',02,'16-April-2017');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,train_id,available_date)values
(013,'Kh1','Dh1',500,'y',01,null);
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,train_id,available_date)values
(014,'Kh1','Dh1',500,'y',01,null);
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,train_id,available_date)values
(015,'Kh1','Dh1',500,'y',01,'22-JUN-2017');


-------------------------------------------------Transaction Process-------------------------------------------------------------------

savepoint train_state;

insert into Train_status(train_id,available_date,total_seats,reserved_seats) values (01,'sunday',50,1);
insert into Train_status(train_id,available_date,total_seats,reserved_seats) values (02,'monday',40,1);
insert into Train_status(train_id,available_date,total_seats,reserved_seats) values (03,'tuesday',50,0);
insert into Train_status(train_id,available_date,total_seats,reserved_seats) values (04,'wednesday',40,0);
insert into Train_status(train_id,available_date,total_seats,reserved_seats) values (05,'Thursday',30,0);


insert into Reservation_status(train_id,seat_id,reserved,customer_name) values(01,1,'y','karim');
insert into Reservation_status(train_id,seat_id,reserved,customer_name) values(01,2,'n',null);
insert into Reservation_status(train_id,seat_id,reserved,customer_name) values(02,3,'y','Rustom');
insert into Reservation_status(train_id,seat_id,reserved,customer_name) values(01,4,'n',null);




select * from train_status;
select distinct* from reservation_status order by train_id;

------------------------------------------------------------Queries/subqueries(part1)-----------------------------------------------


select train_id,Train_status.available_date,Train_status.total_seats,Reservation_status.seat_id,
Reservation_status.customer_name,Reservation_status.reserved from Train_status natural join Reservation_status;


select t.available_date,t.total_seats,t.reserved_seats,r.customer_name,r.seat_id,r.reserved from Train_status t left outer join Reservation_status r
on t.train_id=r.train_id;




--------------------------------------------End Queris/subqueries(part1)-----------------------------------------------


rollback to train_state;

-----------------------------------------------------------------------END TRANSACTION-------------------------------------------------------
select * from train_status;
select distinct * from Reservation_status order by train_id;

--------------------------------------------------------------------------Queries/subqueries(part2)-----------------------------------------------

select station_name from Station where station_id='B1'
union all
select source_stn from Train where destination_id='Dh1';


SELECT p.seat_id,p.slno,p.passenger_name,p.age,p.gender,pt.seat_id,pt.source_id,pt.destination_id,pt.ticket_price,pt.reservation_status,
pt.available_date FROM Passenger p RIGHT OUTER JOIN Passenger_ticket pt
on p.seat_id=pt.seat_id;


select t.train_name,t.source_stn,t.destination_stn,t.source_id,t.destination_id,tc.fare_class1,tc.seat_class1,tc.fare_class2,tc.seat_class2,
tc.fare_class3,tc.seat_class3 from Train t full outer join Train_class tc on t.train_id=tc.train_id;




--------------------------------------------------------------------end Queries/subqueries-----------------------------------------------


-------------------------------------PL/SQL_CODE(procedure,cursor,function,trigger,loop,if statements) for user input--------------------------------------------


set serveroutput on
set echo off;
set define '&';

---------------procedure to add passenger into passenger_ticket----------------



create or replace procedure pass_tck(
sl passenger_ticket.seat_id%type,
rsvd passenger_ticket.reservation_status%type,
t_id passenger_ticket.train_id%type) is

begin
insert into Passenger_ticket(seat_id,reservation_status,train_id) values
(sl,rsvd,t_id);
commit;
end pass_tck;
/
show errors;

--------------------------------end procedure-----------------------


---------------trigger to insert rest data in passenger_ticket------


create trigger p_tck
before update or insert on Passenger_ticket
for each row
begin
if :new.train_id <02 then
:new.source_id:='Kh1';
:new.destination_id:='Dh1';
:new.ticket_price:=price(500);
elsif :new.train_id>01 and :new.train_id<03 then
:new.source_id:='B1';
:new.destination_id:='Dh1';
:new.ticket_price:=price(900);
elsif :new.train_id >02 and :new.train_id<04 then
:new.source_id:='Raj1';
:new.destination_id:='Dh1';
:new.ticket_price:=price(1100);
elsif :new.train_id>03 and :new.train_id<05 then
:new.source_id:='kh1';
:new.destination_id:='B1';
:new.ticket_price:=price(1000);
elsif :new.train_id>04 and :new.train_id<06 then
:new.source_id:='Raj1';
:new.destination_id:='B1';
:new.ticket_price:=price(1500);
end if;
end p_tck;
/
show errors;

-------------------------------end trigger------------------------------------------



-----------------function to calculate ticket_price in passenger-ticket------------

create or replace function price(
tk in number)
return number is
dt date :='26-JUN-2017';
cd date :=current_date;
begin
if (cd) > dt then
dbms_output.put_line('EID DAY EXCEED!!!' || cd);
return (nvl(tk,0))+100;
else
return (nvl(tk,0));
end if;
end price;
/
show errors;

----------------------end function---------------------------------



declare 
t_id int;
avail_d varchar(20);
resvd int;
tot_s int;

cursor cur is select * from Train_status;

begin
insert into Train_status values(&train_id,'&avail_d',&total_seats,0);
open cur;
loop
fetch cur into t_id,avail_d,tot_s,resvd;
if cur%found then
for i in 1..tot_s
loop
insert into Reservation_status values(t_id,i,'n',null);
end loop;
else
exit;
end if;
end loop;
commit;
close cur;
end;
/

--------------------------------------------to see the effect of input--------------------------------------------


select * from Train_status;
select * from Reservation_status;
 

---------------------------------------------Reserve a Seat -----------------------------------------------------
declare
t_id int;
cname varchar(50);
tot_ int;
resv int;
sid int;
sno int;
sl int;
rv char(2);

begin
cname:='&cname';
t_id:=&t_id;

select total_seats into tot_ from Train_status where train_id=t_id;
select  reserved_seats into resv from Train_status where train_id=t_id;

if tot_>resv then
select min(seat_id) INTO sid from Reservation_status where train_id=t_id and reserved='n';
update Reservation_status set reserved='y' where train_id=t_id and seat_id=sid;
update Reservation_status set customer_name=cname where train_id=t_id and seat_id=sid;
update Train_status set reserved_seats=reserved_seats+1 where train_id=t_id;
select reserved into rv from Reservation_status where train_id=t_id and seat_id=sid;
pass_tck(sid,rv,t_id);
else
select max(slno) into sno from Waiting_list;
if sno is null then
sl:=1;
else
sl:=sno+1;
end if;
insert into Waiting_list values(sl,cname,t_id);
pass_tck(sl,'y',t_id);
end if;
end;
/

-----------------------to see the effect of reservation------------------


select distinct* from reservation_status order by train_id;
select * from train_status;
select * from passenger_ticket;

----------------------Queries/Subqueries(part 3)------------------

select seat_id,source_id,destination_id,ticket_price,available_date from Passenger_ticket
where ticket_price>=600 and ticket_price<=2000;


select p.train_id,p.passenger_name from Passenger p where p.train_id in(
select pt.train_id from Passenger_ticket pt,Train t where pt.destination_id=t.destination_id
and pt.available_date >'26-JUN-2016');
--------------------------CANCEL A RESERVATION-------------------

declare
cname varchar(50);
t_id int;
sid int;
sno int;
sl int;


begin
cname:='&cname';
t_id:=&t_id;

select seat_id into sid from reservation_status where train_id=t_id and customer_name=cname;
select MIN(slno) into sno from waiting_list where train_id=t_id;

if sno is not null then
select customer_name into cname from waiting_list where train_id=t_id and slno=sno;
update reservation_status set customer_name=cname where train_id=t_id and seat_id=sid;
delete from waiting_list where train_id=t_id and slno=sno;
delete from Passenger_ticket where train_id=t_id and seat_id=sid;
else
update reservation_status set reserved='n' where train_id=t_id and seat_id=sid;
update reservation_status set customer_name=null where train_id=t_id and seat_id=sid;
update train_status set reserved_seats=reserved_seats-1 where train_id=t_id;
delete from Passenger_ticket where train_id=t_id and seat_id=sid;
end if;
end;
/


select * from train_status;
select distinct* from reservation_status order by train_id;
select * from waiting_list;
select * from passenger_ticket order by train_id;

declare

wis varchar(50):='RAILWAY MANAGEMENT SYSTEM';

begin
dbms_output.put_line('THANKS FOR USING ' || wis);
end;
/