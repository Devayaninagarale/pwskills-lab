--- QUE 1) Retrieve the first_name and last_name from customers who have a postal_code starting with 35 ?

SELECT c.first_name , c.last_name , postal_code
FROM 
   customer c
      INNER JOIN 
address a ON c.address_id = a.address_id
WHERE postal_code like '35%';



--- QUE 2) Display the titles and rental_rate of films that have a rental_rate between 2.00 and 4.00 ?

SELECT title , rental_rate 
FROM
    film 
WHERE rental_rate 
BETWEEN 2 and 4;



--- QUE 3) List the film_names and release_year of films released in the 21st century(after year 2000)?

SELECT title, release_year 
FROM film
WHERE release_year > 2000;



--- QUE 4) Find the actors whose last_name has the letter 'a'. Order the results alphabetically by the names?

SELECT first_name , last_name 
FROM actor
WHERE last_name LIKE '%a%'
ORDER BY first_name;



--- QUE 5) Retrieve the film titles and the rental_duration of the top 5 longest films(ordered by rental duration)

SELECT title , rental_duration
FROM film 
ORDER BY rental_duration desc
LIMIT 5;



--- QUE 6) List the names of customers who have made more than 20 rentals, ordered by the number of rental in descending orders?

SELECT  c.first_name , c.last_name , count(r.rental_id) as number_of_rentals
 FROM 
customer c 
     INNER JOIN 
rental r ON  c.customer_id = r.customer_id
GROUP BY c.first_name , c.last_name
HAVING COUNT(*) > 20
ORDER BY number_of_rentals desc;



--- QUE 7) Find the films that have a replacement_cost greater than 20 and rental rate less than 3 ?

SELECT  title , replacement_cost , rental_rate
 FROM film
WHERE replacement_cost >= 20 AND rental_rate <= 3;



--- QUE 8) Retrieve the customer_names and their total payments, ordered by total payment in descending order, and limit the result to 10 rows.

SELECT c.first_name , c.last_name , sum(p.amount) As total_payment
FROM 
payment p 
   INNER JOIN 
customer c ON p.customer_id = c.customer_id
   INNER JOIN
rental r ON c.customer_id = r.customer_id
GROUP BY c.first_name , c.last_name
order by total_payment desc
limit 10;

