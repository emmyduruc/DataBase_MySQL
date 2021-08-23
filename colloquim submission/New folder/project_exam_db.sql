create schema Parcel_Store_Project;
use parcel_store_project;

drop table Shipping;
drop table Employees;
drop table customer;
drop table parceltype;
drop table parcels;
drop table parcel_store;
drop table Mobility_event;


create table Parcel_Store
(
parcelstore_ID INT,
P_name VARCHAR(30)NOT NULL,
City VARCHAR(30) NOT NULL,
Postcode INT NOT NULL,
Street_name VARCHAR(30) NOT NULL,
Street_Nr INT NOT NULL,
primary key (parcelstore_ID)
);


create table parcels
(
parcel_Id INT NOT NULL,
store_ID INT NOT NULL,
weight VARCHAR(10) NOT NULL,
final_destination VARCHAR(30) NOT NULL,
delivery_date DATE NOT NULL,
primary key(parcel_Id),
foreign key (store_ID) references Parcel_Store(parcelstore_ID)
);

create table Mobility_event
(
mobility_ID INT NOT NULL,
mobility_type VARCHAR(20),
primary key (mobility_ID)
);

create table Shipping
(
parcel_ID INT NOT NULL,
mobility_ID INT NOT NULL,
primary key (mobility_ID,parcel_ID),
foreign key (mobility_ID) references Mobility_event(mobility_ID),
foreign key (parcel_ID) references parcels(parcel_ID)
);

create table Employees
(
store_ID INT NOT NULL,
Essn INT NOT NULL,
Fname VARCHAR(20),
Lname VARCHAR(20),
E_address VARCHAR(30),
E_Bdate Date,
E_Sex VARCHAR(10),
Salary INT NOT NULL,
primary key (Essn),
foreign key(store_ID) references Parcel_Store(parcelstore_ID)
);

create table parceltype
(
parcel_Id INT NOT NULL,
parcel_type VARCHAR(15) NOT NULL,
primary key (parcel_type,parcel_Id),
foreign key (parcel_id) references parcels(parcel_Id)
);


create table Customer
(
C_ID INT NOT NULL,
phoneNum VARCHAR(15)NOT NULL,
C_Address VARCHAR(30),
Fname VARCHAR(20),
Lname VARCHAR(20),
primary key (C_ID)
);

INSERT INTO customer VALUES
(004,'+491539197538','unnastr. 9 20253 Hamburg','Hilary','Ogalagu'),
(010,'+491539192338','unnastr. 9 20253 Hamburg','Regina','Daniels'),
(006,'+491599197438','quickbonstr. 9 20253 Hamburg','Renz','wolfgang'),
(008,'+49149197038','lehmweg. 41 25332 Hamburg','Adriana','Duru'),
(003,'+491539197521','mittweg 23 20243 Hamburg','Austin','Ogu');
INSERT INTO customer VALUES
(005,'+491530097538','billstr. 9 20253 Hamburg','kola','steph'),
(001,'+491560097538','magretstr. 40 34353 berlin','dele','abel'),
(002,'+49156009638','allinstr. 40 2030 berlin','zoin','nena');
INSERT INTO mobility_event VALUES
(502,'A truck'),
(402,'A van'),
(302,'A bike'),
(202,'A car'),
(102,'A truck');

INSERT INTO Parcel_Store VALUES 
(204,'ANSEC','Hamburg',20148,'Bundestrasse',8),
(205,'ANSEC','Hamburg',20009,'Alckermanstrasse',34),
(206,'ANSEC','Hamburg',20532,'Altonastrasse',3),
(209,'ANSEC','Hamburg',20428,'gregstr',54),
(207,'ANSEC','Hamburg',22046,'Eppendorfer Weg',21);
INSERT INTO Parcel_Store VALUES (210,'ANSEC','Hamburg',20428,'solastr',4);

INSERT INTO employees VALUES
(204, 2615, 'jude','ogbonna','jogbonna@gmail.com',str_to_date('1994-03-01','%Y-%m-%d'), 'male', '20000'),
(209, 2355, 'jude','ogbonna','jogbonna@gmail.com',str_to_date('1994-03-01','%Y-%m-%d'), 'female', '20000'),
(205, 3015, 'mathew','leonard','ml@gmail.com',str_to_date('1985-07-12','%Y-%m-%d'), 'male', '10000'),
(206, 2425, 'margret','gerrad','stgerrad@gmail.com',str_to_date('1993-03-30','%Y-%m-%d'), 'female', '30000'),
(207, 1765, 'lukaku','ogbonna','luognna@gmail.com',str_to_date('1990-04-05','%Y-%m-%d'), 'male', '23000');
INSERT INTO employees VALUES    
(210, 2252, 'Drake','Hensel', 'drakehe@gmail.com',str_to_date('1990-05-05','%Y-%m-%d'), 'male', '2000');
delete from employees 
where Essn = 6352;
INSERT INTO employees VALUES    
(207, 6352, 'Nena','Hensel', 'nena@yahoo.com',str_to_date('1990-04-05','%Y-%m-%d'), 'female', '3000');

INSERT INTO parcels VALUES
(001,204, '8.6KG', '8 Berliner Tor 23246 Hamburg',str_to_date('2021-04-13','%Y-%m-%d'));
INSERT INTO parcels VALUES
(002,209, '10.6KG', '90 neindorfstr.  23246 Hamburg',str_to_date('2021-03-04','%Y-%m-%d'));
INSERT INTO parcels VALUES
(003,205, '5.6KG', '12 frohmestr. 23246 Hamburg',str_to_date('2021-07-24','%Y-%m-%d'));
INSERT INTO parcels VALUES
(004,206, '8.6KG', '21 sedanstr. 20146 Hamburg',str_to_date('2021-10-23','%Y-%m-%d'));
INSERT INTO parcels VALUES
(005,207, '63.6KG', '21 heimfieldstr. 20146 Hamburg',str_to_date('2021-10-23','%Y-%m-%d'));


INSERT INTO parceltype VALUES
(001,'Incoming'),
(002,'outgoing'),
(004,'Incoming'),
(003,'incoming'),
(005,'Incoming');

INSERT INTO shipping VALUES
(001,502),
(002,402),
(003,302),
(004,202),
(005,102);

#Test cases 1
delete from customer where C_ID = 10;

#Test case 2
UPDATE employees
SET salary = 35000
Where Essn = 2355;

#Test case 3
select Fname, Lname
from customer;

#Test case 4
select store_ID,final_destination,weight
from parcels AS p
join shipping AS s on p.parcel_ID = s.parcel_ID;

#Test case 5
select* from parceltype where parcel_type = 'incoming'
order by parcel_ID desc;

#Select---------------------?????
select delivery_date, Fname,Lname,C_address
from customer inner join parcels
on C_ID = parcel_Id
order by Fname;



#view-----------
drop view delivery;
create view Delivery 
AS select p.store_ID, p.final_destination , pt.parcel_type, p.delivery_date
from parcels p, parceltype pt
where p.parcel_Id = pt.parcel_Id;

create view parcelstore_addresses
AS select ps.Street_name, ps.Street_Nr, ps.city
from parcel_store ps; 

create view high_salary as
select count(*)from employees where salary>10000;

#join-----gets list of which customer has a parcel in a store considering if its an outgoing or incoming parcel-----
select customer.C_ID,customer.Fname,customer.Lname,customer.C_address, parceltype.parcel_type, parcels.store_ID, parcels.parcel_Id
From customer, parceltype 
inner join parcels
where customer.C_ID = parceltype.parcel_Id and parceltype.parcel_Id = parcels.parcel_Id;

##----------to get the delivery date and which parcel was delivered to a customer
select delivery_date, Fname,Lname,C_address, parcel_Id
from customer join parcels
on C_ID = parcel_Id
order by Fname;

#---gets the list of all customers information, their parcel_id's and if its an incoming parcel or outgoing parcel-------
select* from customer
left join parceltype
on customer.C_ID = parceltype.parcel_Id;

#-----to achieve the parcel final destination of every incoming and outgoing parcels with the mobility event and if its an incoming or outgoing parcels
select parcels.store_ID,parcel_store.P_name,parcel_store.City,shipping.mobility_ID,mobility_event.mobility_type, parceltype.parcel_type, parcels.delivery_date,parcels.final_destination
from parcels,parcel_store,mobility_event, parceltype
inner join shipping
where parcels.parcel_Id = shipping.parcel_ID and parcels.store_ID = parcel_store.parcelstore_ID and mobility_event.mobility_ID = shipping.mobility_ID and parceltype.parcel_Id = parcels.parcel_Id;

#aggregates----------------------------------
select count(weight) from parcels;
select count(*)from employees where salary>10000;
select min(salary) AS salary FROM employees; 
select max(salary) AS salary FROM employees;

#Grouping----------------------------
select delivery_date,sum(weight) AS total_day_weight
From parcels
group by delivery_date;


#Transaction-------------------------
  START TRANSACTION;  
  
-- 2. Get the highest salary  
 
SELECT @salary:= MAX(salary) FROM employees;  

INSERT INTO employees(store_ID, Essn, Fname, Lname,E_address,E_Bdate,E_Sex, salary)   
VALUES (301, 4334, 'Frank','lampard', 'frank@gmail.com', str_to_date('1994-03-01','%Y-%m-%d'), 'male', '90000');

-- 4. I Inserted a new record into the parcel_store table  
  
INSERT INTO parcel_store(parcelstore_ID, P_name, City, Postcode,Street_name,Street_Nr)   
VALUES (208, 'ANSEC', 'Berlin',38219,'alexanderstr', 10);  
  
-- 5. then i Committed the changes      
COMMIT; 

#Trigger-----------------------------
DROP TRIGGER IF EXISTS emp_salary;
DELIMITER // 
Create Trigger before_insert_emp_salary
BEFORE INSERT ON employees FOR EACH ROW  
BEGIN  
IF NEW.salary < 5000 THEN SET NEW.salary = 0;  
END IF; 
END // 
INSERT INTO employees VALUES    
(207, 6352, 'Nena','Hensel', 'nena@yahoo.com',str_to_date('1990-04-05','%Y-%m-%d'), 'female', '3000');  
  


    




