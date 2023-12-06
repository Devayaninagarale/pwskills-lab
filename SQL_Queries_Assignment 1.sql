-- Que 1)--  Identify the primary keys and foreign keys in mavenmovies db. Discuss the differences ?

-- Primary key-  
-- Is a id which is unique for particular person and which identify whole row
-- Properties of primary key- 1) values should npt be null , 2) values should be unique

-- foreign key-
-- Is a  primary key of table which we are using as a referal key at that particular table

use mavenmovies;
select * from actor_award;
--  primary key:  'actor_award_id'
--  foreign key : 'actor_id' references (language_id)
 
 select * from address;
--  primary key:  'address_id'
--  foreign key : 'city_id' references (city_id)

select * from advisor;
--  primary key:  'advisor_id'

select * from city;
--  primary key:  'city_id'
--  foreign key : 'country_id' references (country_id)

select * from country;
--  primary key:  'country_id'

select * from customer;
--  primary key:  'customer_id'
--  foreign key : 'address_id' references (address_id)

select * from film;
--  Primary key : 'film_id'
--  foreign key : 'language_id' references (language_id)

select * from film_actor;
-- Primary key : 'actor_id','film_id'
--  foreign key :  'actor_id' references (actor_id) , 'film_id' references (film_id)

select * from film_category;
-- Primary key : 'film_id' , 'category_id'
--  foreign key :  'film_id' references (film_id) , 'category_id' references (category_id)

select * from film_text;
--  Primary key : 'film_id'

select * from payment;
-- Primary key : 'payment_id' , 
--  foreign key :  'rental_id' references (rental_id) , 'staff_id' references (staff_id)


-- QUE 2)--  List all details of actors ?
select * from  film_actor, actor_award , film;

-- QUE 3)--  List all customer informatiom from Database ?
select * from customer;
select first_name , last_name , email from customer;

-- QUE 4)-- List different countries ?
select distinct(country) from country;

-- QUE 5)-- Display all active customers ?
select * from customer;
select first_name , last_name , active from customer where active = 1;


-- QUE 6)-- List of all rental IDs for customer with ID 1 ?
select * from rental;
select rental_id , customer_id from rental where customer_id = 1;


-- QUE 7)-- Display all the films whose rental duration is greater than 5 ?
select * from film;
select title , rental_duration from film where rental_duration > 5;


-- QUE 8)-- List the total number of films whose replacement_cost is greater than $15 and less than $20 ?
select * from film;
select title , replacement_cost from film where replacement_cost between 15 and 20;


-- QUE 9)-- Find the number of films whose rental_rate is less than $1 ?
select * from film;
select title , rental_rate from film where rental_rate < 1;


-- QUE 10)-- Display the count of unique first names of actors ?
select count(distinct(first_name)) from film_actor, actor;


-- QUE 11)-- Display the first 10 records from the customer table ?
select * from customer;
select first_name , last_name from customer where customer_id between 1 and 10;


-- QUE 12)-- Display the first 3 records from the customer table whose first name start with 'b' ?
select * from customer;
select first_name from customer where first_name like "B%"  limit 3;


-- QUE 13)-- Display the  name of first 5 movies which are rated as 'G'
select * from film;
select title from film where rating = "G" limit 5;


-- QUE 14)-- Find all customers whose first name start with 'a'
select * from customer;
select first_name from customer where first_name like "A%";


-- QUE 15)-- Find all customers whose first name ends with 'a'
select * from customer;
select first_name from customer where first_name like "%A";


-- QUE 16)-- Display the list of first 4 cities which starts and ends with 'a'
select * from city;
select city from city where city like "A%A" limit 4;


-- QUE 17)-- Find all the customers whose first name have "NI" in any position ?
select * from customer;
select first_name from customer where first_name like "%ni%";


-- QUE 18)-- Find all the customers whose first name have "r" in second position ?
select * from customer;
select first_name from customer where first_name like "_r%";


-- QUE 19)-- Find all customers whose first name start with 'a' and are atlest 5 characters in length ?
select * from customer;
select first_name from customer where first_name like "A%" and  (length(first_name)) = 5;


-- QUE 20)-- Find all the customers whose first name start with 'a' and ends with 'o' ?
select * from customer;
select first_name from customer where first_name like "A%O";


-- QUE 21)-- Get the film with pg and pg-13 rating using IN operator ?
select * from film;
select title , rating from film where rating  in ("PG" , "PG-13");


-- QUE 22)-- Get the film with length between 50 to 100 using between operator ?
select * from film;
select title , length from film where Length  between 50 and 100;


-- QUE 23)-- Get the top 50 actors using limit operator.
select * from film;
select * from film_actor , actor_award limit 50;


-- QUE 24)-- Get the Distinct film ids from inventory table.
select distinct film_id from inventory;






