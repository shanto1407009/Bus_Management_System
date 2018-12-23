set serveroutput on
set echo off;
set define '&';


drop table Stand cascade constraints;
drop table Bus cascade constraints;
drop table Passenger cascade constraints;
drop table Passenger_ticket cascade constraints;
drop table Bus_status cascade constraints;
drop table Reservation_status cascade constraints;
drop table Adminn cascade constraints;



----------------------------Tables------------------------------------------




create table Stand(
stand_id varchar(10) not null,
stand_name varchar(25)
);

alter table Stand add constraint stand_id primary key(stand_id);


create table Bus(
bus_id int not null,
bus_name varchar(20) not null,
source_stnd varchar(30),
destination_stnd varchar(30),
source_id varchar(10),
destination_id varchar(10),
primary key(bus_id),
foreign key(source_id) references Stand(stand_id) on delete cascade,
foreign key(destination_id) references Stand(stand_id) on delete cascade
);


create table Passenger(
seat_id int not null,
slno int not null,
passenger_name varchar(50) not null,
age int not null,
gender varchar(8) not null,
bus_id int not null,
foreign key(bus_id) references Bus(bus_id) on delete cascade,
primary key(seat_id,slno)
);


create table Passenger_ticket(
seat_id int not null,
source_id varchar(8) ,
destination_id varchar(8),
ticket_price number(8),
reservation_status char(2) not null,
bus_id int not null,
available_date date,
foreign key(bus_id) references Bus(bus_id) on delete cascade,
primary key(seat_id)
);


create table Bus_status(
bus_id int not null,
available_date varchar(20) not null,
total_seats int,
reserved_seats int,
primary key(bus_id)
);



create table Reservation_status(
bus_id int not null,
seat_id int not null,
reserved char(2) CHECK (reserved in('y','n')),
customer_name varchar(50),
foreign key(bus_id) references Bus_status(bus_id) on delete cascade
);


create table Adminn(
id int not null,
name varchar(50),
pass varchar(50),
primary key(id)
);
-----------------------------------Inserting Data into Tables-------------------------------------------------- 

insert into Stand(stand_id,stand_name) values('C1','Chittagong Stand');
insert into Stand(stand_id,stand_name) values('Dh1','Dhaka Stand');
insert into Stand(stand_id,stand_name) values('Raj1','Rajshahi Stand');
insert into Stand(stand_id,stand_name) values('Kh1','Khulna Stand');

insert into Bus(Bus_id,Bus_name,source_stnd,destination_stnd,source_id,destination_id) values(01,'BRTC','Khulna','Dhaka','Kh1','Dh1');
insert into Bus(Bus_id,Bus_name,source_stnd,destination_stnd,source_id,destination_id) values(02,'Agomoni Express','Chittagong','Dhaka','C1','Dh1');
insert into Bus(Bus_id,Bus_name,source_stnd,destination_stnd,source_id,destination_id) values(03,'SK Poribahan','Rajshahi','Dhaka','Raj1','Dh1');
insert into Bus(Bus_id,Bus_name,source_stnd,destination_stnd,source_id,destination_id) values(04,'Shohag','Khulna','Chittagong','Kh1','C1');
insert into Bus(Bus_id,Bus_name,source_stnd,destination_stnd,source_id,destination_id) values(05,'RP Poribahan','Rajshahi','Chittagong','Raj1','C1');


insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(011,1,'poli',20,'female',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(012,2,'ratul',30,'male',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(021,1,'raja',40,'male',02);
insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(022,2,'rahul',45,'male',02);
insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(013,3,'poni',56,'male',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(014,4,'kobir',20,'male',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(015,5,'koli',25,'male',01);
insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(031,1,'akashi',33,'female',03);
insert into Passenger(seat_id,slno,passenger_name,age,gender,bus_id) values
(041,1,'korobi',20,'female',04);


insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,bus_id,available_date)values
(011,'Kh1','Dh1',500,'y',01,'26-DEC-2016');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,bus_id,available_date)values
(012,'Kh1','Dh1',500,'y',01,'10-MAR-2017');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,bus_id,available_date)values
(021,'C1','Dh1',900,'y',02,'23-FEB-2017');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,bus_id,available_date)values
(022,'C1','Dh1',900,'y',02,'16-DEC-2016');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,bus_id,available_date)values
(013,'Kh1','Dh1',500,'y',01,'5-MAR-2017');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,bus_id,available_date)values
(014,'Kh1','Dh1',500,'y',01,'25-NOV-2016');
insert into Passenger_ticket(seat_id,source_id,destination_id,ticket_price,reservation_status,bus_id,available_date)values
(015,'Kh1','Dh1',500,'y',01,'22-JUN-2017');


insert into Adminn values (1,'s','t');
insert into Adminn values (2,'w','v');
-------------------------------------------------Transaction Process-------------------------------------------------------------------

savepoint bus_state;

insert into Bus_status(bus_id,available_date,total_seats,reserved_seats) values (01,'sunday',50,1);
insert into Bus_status(bus_id,available_date,total_seats,reserved_seats)  values (02,'monday',40,1);
insert into Bus_status(bus_id,available_date,total_seats,reserved_seats)  values (03,'tuesday',50,0);
insert into Bus_status(bus_id,available_date,total_seats,reserved_seats)  values (04,'wednesday',40,0);


insert into Reservation_status(bus_id,seat_id,reserved,customer_name) values(01,1,'y','karim');
insert into Reservation_status(bus_id,seat_id,reserved,customer_name) values(01,2,'n',null);
insert into Reservation_status(bus_id,seat_id,reserved,customer_name) values(02,3,'y','mehurunnissa');
insert into Reservation_status(bus_id,seat_id,reserved,customer_name) values(01,4,'n',null);
insert into Reservation_status(bus_id,seat_id,reserved,customer_name) values(04,5,'y','mostofa');



--------------------------------------------------------Queries/subqueries-----------------------------------------------



select seat_id,bus_id,available_date from Passenger_ticket where available_date between '1-JAN-2017' and '20-JUN-2017';

select stand_name from Stand where stand_id='C1'
union all
select source_stnd from Bus where destination_id='Dh1';


select p.seat_id,p.passenger_name from Passenger p where p.seat_id in(
select pt.seat_id from Passenger_ticket pt where pt.available_date<'1-JAN-2017');

select b.available_date,b.total_seats,b.reserved_seats,r.customer_name,r.seat_id,r.reserved from Bus_status b left outer join Reservation_status r
on b.bus_id=r.bus_id;

SELECT p.seat_id,p.slno,p.passenger_name,p.age,p.gender,pt.seat_id,pt.source_id,pt.destination_id,pt.ticket_price,pt.reservation_status,
pt.available_date FROM Passenger p RIGHT OUTER JOIN Passenger_ticket pt
on p.seat_id=pt.seat_id;

select * from Bus_status;
select distinct * from reservation_status order by bus_id;


--------------------------------------PLSQL Code(login)--------------------------------------------------------


declare 

seatt_id int;
b_id int;
rv_st int;
rs char(2);
unm varchar(50);
upa varchar(50);
username varchar(50);
userpass varchar(50);

begin
username:='&username';
userpass:='&userpass';
seatt_id :=&seatt_id;
b_id:=&b_id;
rv_st :=&rv_st;
rs:='&rs';
select name into unm from Adminn where name=username;
select pass into upa from Adminn where name=username;

if upa=userpass then
dbms_output.put_line('YOU ARE ALLOWED TO CONTINUE. WELCOME ' || username);
update Bus_status set reserved_seats=rv_st where bus_id=b_id;
update Reservation_status set reserved=rs where bus_id=b_id and seat_id=seatt_id;
else
dbms_output.put_line('YOU ARE NOT ALLOWED, '|| username);
end if;
end;
/

select * from Bus_status;
select * from Reservation_status order by bus_id;



rollback to bus_state;

-----------------------------------------------------------------------END TRANSACTION-------------------------------------------------------

select * from Bus_status;
select distinct * from Reservation_status order by bus_id;


-------------------------------------PL/SQL_CODE(procedure,cursor,function,trigger,loop,if statements) for user input--------------------------------------------



---------------procedure to add passenger into passenger_ticket----------------



create or replace procedure pass_tck(
sl passenger_ticket.seat_id%type,
rsvd passenger_ticket.reservation_status%type,
b_id passenger_ticket.bus_id%type) is

begin
insert into Passenger_ticket(seat_id,reservation_status,bus_id) values
(sl,rsvd,b_id);
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
if :new.bus_id <02 then
:new.source_id:='Kh1';
:new.destination_id:='Dh1';
:new.ticket_price:=price(500);
elsif :new.bus_id>01 and :new.bus_id<03 then
:new.source_id:='C1';
:new.destination_id:='Dh1';
:new.ticket_price:=price(900);
elsif :new.bus_id >02 and :new.bus_id<04 then
:new.source_id:='Raj1';
:new.destination_id:='Dh1';
:new.ticket_price:=price(1100);
elsif :new.bus_id>03 and :new.bus_id<05 then
:new.source_id:='kh1';
:new.destination_id:='C1';
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
dbms_output.put_line('EID DAY!!!' || cd);
return (nvl(tk,0))+100;
else
return (nvl(tk,0));
end if;
end price;
/
show errors;

----------------------end function---------------------------------



declare 
b_id int;
avail_d varchar(20);
resvd int;
tot_s int;

cursor cur is select * from Bus_status;

begin
insert into Bus_status values(&bus_id,'&avail_d',&total_seats,0);
open cur;
loop
fetch cur into b_id,avail_d,tot_s,resvd;
if cur%found then
for i in 1..tot_s
loop
insert into Reservation_status values(b_id,i,'n',null);
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


select * from Bus_status;
select * from Reservation_status;
 

---------------------------------------------Reserve a Seat -----------------------------------------------------
declare
b_id int;
cname varchar(50);
tot_ int;
resv int;
sid int;
sno int;
sl int;
rv char(2);

begin
cname:='&cname';
b_id:=&b_id;

select total_seats into tot_ from Bus_status where bus_id=b_id;
select  reserved_seats into resv from Bus_status where bus_id=b_id;

if tot_>resv then
select min(seat_id) INTO sid from Reservation_status where bus_id=b_id and reserved='n';
update Reservation_status set reserved='y' where bus_id=b_id and seat_id=sid;
update Reservation_status set customer_name=cname where bus_id=b_id and seat_id=sid;
update Bus_status set reserved_seats=reserved_seats+1 where bus_id=b_id;
select reserved into rv from Reservation_status where bus_id=b_id and seat_id=sid;
pass_tck(sid,rv,b_id);
else
select max(seat_id) into sno from Reservation_status;
if sno is null then
sl:=1;
else
sl:=sno+1;
end if;
pass_tck(sl,'y',b_id);
end if;
end;
/

-----------------------to see the effect of reservation------------------


select distinct* from reservation_status order by bus_id;
select * from Bus_status;
select * from passenger_ticket;

----------------------Queries(TIcket price between 600 and 2000)------------------

select seat_id,source_id,destination_id,ticket_price,available_date from Passenger_ticket
where ticket_price>=500 and ticket_price<=1000;


--------------------------CANCEL RESERVATION-------------------

declare
cname varchar(50);
b_id int;
sid int;
sno int;
sl int;


begin
cname:='&cname';
b_id:=&b_id;

select seat_id into sid from reservation_status where bus_id=b_id and customer_name=cname;

update reservation_status set reserved='n' where bus_id=b_id and seat_id=sid;
update reservation_status set customer_name=null where bus_id=b_id and seat_id=sid;
update Bus_status set reserved_seats=reserved_seats-1 where bus_id=b_id;
delete from Passenger_ticket where bus_id=b_id and seat_id=sid;
end;
/


select * from Bus_status;
select distinct* from reservation_status order by bus_id;
select * from passenger_ticket order by bus_id;

declare

gt varchar(50):='BUS MANAGEMENT SYSTEM';

begin
dbms_output.put_line('THANKS FOR USING ' || gt);
end;
/
