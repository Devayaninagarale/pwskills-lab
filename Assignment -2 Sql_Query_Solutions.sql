-- QUE 1)  Retrieve the total number of rentals made in Sakila database ?

use mavenmovies;
select Count(*) from rental;


-- QUE 2) Find the average rental duration (in days) of movies rented from Sakila database ?

select avg(datediff(return_date , rental_date)) from rental;



-- STRING FUNCTION

-- QUE 3) Display the first name and last name of customers in uppercase ?

select * from customer;
select concat(first_name , " " ,last_name) as upper from customer;


-- 	QUE 4) Extract the month from the rental date and display it alongside the rental ID ?

select * from rental;
select rental_ID , month(rental_date) as rental_month from rental;



-- GROUP BY

-- QUE 5) Retrieve the count of rentals for each customer(display customer ID and the count of rentals)

select * from customer;
select customer_id , COUNT(rental_id) As rental_count from rental group by customer_id;



-- QUE 6) Find the total revenue generated by each store ?

select * from store;
select * from staff;
select * from address;
select * from city;
select * from country;
select * from customer;
select * from payment;
SELECT 
    store.store_id,
    store.manager_staff_id,
    SUM(payment.amount) AS total_revenue
FROM
    store 
        INNER JOIN
    staff  ON store.manager_staff_id = staff.staff_id
        INNER JOIN
    address  ON store.address_id = address.address_id
        INNER JOIN
    city  ON address.city_id = city.city_id
        INNER JOIN
    country ON city.country_id = country.country_id
        INNER JOIN
    customer ON store.store_id = customer.store_id
        INNER JOIN
    payment  ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;



-- JOINS

-- QUE 7) Display the title movie customer's first name and last name who rented it ?

select * from film; -- film_id
select * from inventory;
select * from rental; --
select * from customer; --
SELECT 
    film.title AS movie_title, customer.first_name, customer.last_name
FROM
    film 
        INNER JOIN
    inventory  ON film.film_id = inventory.film_id
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
        INNER JOIN
    customer  ON rental.customer_id = customer.customer_id;



-- QUE 8) Retrieve the names of all actors who have appeared in the film 'GONE WITH THE WIND' ?

select * from actor;
select * from film_actor;
select * from film;
SELECT 
    actor.first_name, actor.last_name
FROM
    actor
        INNER JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
        INNER JOIN
    film ON film_actor.film_id = film.film_id
WHERE
    film.title = 'GONE WITH THE WIND';




-- GROUP BY

-- QUE 1) Determine the total number of rentals for each category of movies

select * from category;  -- category_id
select * from film_category;  
select * from film; -- film_id
select * from inventory;
select * from rental;
SELECT 
    c.name AS category, COUNT(*) AS total_rentals
FROM
    category c
        INNER JOIN
    film_category ON c.category_id = film_category.category_id
        INNER JOIN
    film ON film_category.film_id = film.film_id
        INNER JOIN
       inventory ON  film.film_id = inventory.film_id
 GROUP BY c.name;
 
 
 
-- QUE 2) Find the average rental rate of movies in each language.

select * from film;
select * from language;
select * from inventory;
select * from film_category;
select * from category; 
SELECT 
    language.name AS language,
    AVG(film.rental_rate) AS avg_rental_rate
FROM
   film
        INNER JOIN
    language ON film.language_id = language.language_id
       INNER JOIN
	inventory ON film.film_id = inventory.film_id
     INNER JOIN 
	film_category ON inventory.film_id = film_category.film_id
    INNER JOIN
	category ON film_category.category_id = category.category_id
    GROUP BY language.name;
    


-- JOINS

-- QUE 3) Retrive the customers name along with the total amount they've spent on rentals 

select * from customer;
select * from payment; 
select * from rental; 
SELECT 
	c.customer_id,
    c.first_name,
    c.last_name, SUM(p.amount) AS total_amount_spent 
    FROM customer c
       INNER JOIN
    payment p  ON c.customer_id = p.customer_id
       INNER JOIN
    rental r  ON p.rental_id = r.rental_id
GROUP BY c.customer_id , c.first_name , c.last_name 
ORDER BY total_amount_spent Asc;
    
    
    
-- QUE 4)  List the titles of movies rented by each customer in a particular city(e.g;,'London')

select * from customer;
select * from address;
select * from city;
select * from rental;
select * from inventory;
select * from film;
select * from country;
SELECT 
    customer.customer_ID,
    customer.first_name,
    customer.last_name,
    film.title
FROM
    customer
        INNER JOIN
    address ON customer.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
        INNER JOIN 
    rental ON customer.customer_id = rental.customer_id
        INNER JOIN 
	inventory ON rental.inventory_id = inventory.inventory_id
       INNER JOIN
	film ON inventory.film_id = film.film_id
    Where city = "London";

    

-- ADVANCED JOINS AND GROUP BY

-- QUE 5) Display the top 5 Rented movies along with the number of times they've been rented

select * from film;
select * from inventory;
select * from rental;
SELECT 
    film.title As Movie_title, 
    rental.customer_id,
    COUNT(rental.rental_Id) AS total_times_rented
FROM
    rental
        INNER JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
     INNER JOIN 
film ON inventory.film_id = film.film_id
Group by film.title , customer_id
limit 5;



-- QUE 6) Determine the customers who have rented movies from both stores(store ID-1 and store ID-2) 

select * from inventory;
select * from rental;
select * from customer;
select * from store;
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name
FROM
    customer
        INNER JOIN
    rental ON customer.customer_id = rental.customer_id
         INNER JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
    where inventory.store_id in ( 1 , 2 )
    group by  customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(DISTINCT inventory.store_id) = 2;





