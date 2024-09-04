create database car_dekho;
use car_dekho;
select * from cars;
select count(*) from cars;  #to get total number of rows in the table
#rows = 7929
describe cars;
select distinct(fuel) from cars;
select count(distinct(fuel)) from cars;
select distinct(transmission) from cars;
set sql_safe_updates=0;
update cars set transmission='Automatic' where transmission=' Automatic';
update cars set Name=trim(Name);
select trim(name) as name1 from cars order by trim(name);
select * from cars order by Name;
select * from cars where fuel='Diesel' order by name;
select count(*) from cars where fuel='Diesel'; #gives the number of diesel vehicles 
# 4304 diesel vehicles
select fuel,count(*) from cars group by fuel; #the count of vehicles in each fuel 
select fuel,count(*)as count from cars group by fuel order by count desc limit 2; #the count of vehicles of top 2 fuel consumed 
select fuel,avg(selling_price) as avg_price from cars group by fuel;
select substring_index(name," ",1) from cars; # cutting a string into a substring 
alter table cars add column Company varchar(100); # adding the substring to a new column in the table
alter table cars modify Company varchar(100) first; # moving that column to first of the table

# updating the datatype of mileage
update cars set mileage=trim(mileage); #trimming any spaces infront of the mileage in the table
update cars set mileage=substring_index(mileage,".",1); # making the substring based on . 
alter table cars modify engine int; # changinfg the datatype of mileage

#updating datatype of max_power
delete from cars where name='Maruti Omni CNG'; # deleting a row 
update cars set max_power=trim(max_power);
update cars set max_power=substring_index(max_power,"b",1);
alter table cars modify max_power float;

# updating the datatype of torque
update cars set torque=trim(substring_index(torque,' ',1));
alter table cars modify torque int;

#updating datatype of engine
update cars set engine=trim(substring_index(engine,' ',1));
alter table cars modify engine int;

select * from cars limit 10,2;


# categorizing km_driven 
select km_driven, case when km_driven<10000 then 'Less than 10k' # using case to give a condition 
when km_driven>=10000 and km_driven<=100000 then 'between 10k and 100k'
else 'Above 100k' end as category_km from cars; # end statement - to clarify thats the end of the case and putting 
												# it in a new column in the table


# categorizing mileage 
alter table cars add column mileage_category varchar(50); # creating a new column in the table 
update cars set mileage_category=case when mileage<10 then "low"
when mileage>=10 and mileage<=20 then "average"
else "high" end ;

#to find whose selling price is the highest 
select mileage_category,max(selling_price) from cars group by mileage_category ;

#number of cars whose transmission is automatic
select transmission,count(*) from cars where transmission="Automatic";

#number of vehicles with max_power of 100.5
select count(max_power) from cars where max_power=100.5;

#number of vehicles with max power of 120 or more
select count(*) from cars where max_power>=120;

#comapany with the max number of vehicles
select company,count(company) from cars group by company order by count(company);

# creating a temp tab new1 inserting all the data from cars by grouping them to remove duplicates 
create temporary table new1 select Company,Name,year,selling_price,km_driven,fuel,seller_type,transmission,owner,mileage,engine,max_power,torque,seats,mileage_category from cars group by Company,Name,year,selling_price,km_driven,fuel,seller_type,transmission,owner,mileage,engine,max_power,torque,seats,mileage_category;
delete from cars;
insert into cars select * from new1;

create temporary table tab1 select Company,year,fuel,mileage from cars;
select * from tab1;

# creating a new column date in table
alter table cars add column current_date1 date;
update cars set current_date1=current_date(); # current date is given value using an already existing function named 
											  # current_date() which enters todays date into the column.
select current_date1 from cars;
select day(current_date1) from cars;
select month(current_date1) from cars;
select year(current_date1) from cars;
select dayname(current_date1) from cars;

select fuel,count(*) from cars group by fuel;
select owner,count(*) from cars group by owner order by count(*) desc limit 1 ;
select avg(mileage) from cars group by transmission;