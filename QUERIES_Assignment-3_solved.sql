-- QUE 1) Write a query to display customer's first_name , last_name , email and city they live in ?

SELECT 
    first_name, last_name, email , city.city
FROM
  customer 
        INNER JOIN
address ON customer.address_id = address.address_id
       INNER JOIN
city ON address.city_id = city.city_id;
    
    
    
--- QUE 2) Retrieve the film_title , description and release year for the film that has the longest duration ?

SELECT 
    film.title As Film_title, film.description, release_year , film.length As film_duration
FROM
    film  
WHERE film.length = (select MAX(film.length) from film);



--- QUE 3) List the customer_name , rental date and film_title for each rental made. Include customer who have never rented a film ?

SELECT 
   c.customer_id , c.first_name , c.last_name,  r.rental_date , f.title As film_title
  FROM customer c 
        LEFT JOIN
rental r ON c.customer_id = r.customer_id
     LEFT JOIN 
inventory i  ON r.inventory_id = i.inventory_id
     LEFT JOIN
film f ON i.film_id = f.film_id
ORDER BY c.customer_id , film_title;
    


--- QUE 4) Find the number of actors for each film. Display the film_title and the number of actors for each film ?

SELECT 
    film.title AS film_title,
    (SELECT 
            COUNT(actor.actor_id)
        FROM
            actor
                INNER JOIN
            film_actor ON actor.actor_id = film_actor.actor_id
        WHERE
            film_actor.film_id = film.film_id) AS Total_actors
FROM
    film;
 


--- QUE 5) Display the first_name , last_name and email of customers along with rental date , film_title and rental return date ?

SELECT 
    c.first_name, c.last_name, c.email , r.rental_date , f.title As film_title , r.return_date As rental_return_date
FROM
    customer c
        INNER JOIN
rental r ON c.customer_id = r.customer_id
       INNER JOIN 
inventory i ON r.inventory_id = i.inventory_id
     INNER JOIN
film f ON i.film_id = f.film_id
Order by c.customer_id;

    
    
--- QUE 6) Retrieve the film titles that are rented by customer whose email domain ends with '.org'. ?

select  c.customer_id , c.first_name , c.last_name , f.title , c.email 
 FROM 
 film f
       INNER JOIN
inventory i ON f.film_id = i.film_id
       INNER JOIN
 rental r ON i.inventory_id = r.inventory_id
    INNER JOIN 
 customer c ON r.customer_id = c.customer_id
 where c.customer_id in (SELECT r.customer_id from rental r join customer c ON r.customer_id = c.customer_id where c.email like '%.org'); -- Domain end with .'net' not available



--- QUE 7) Show the total number of rentals made by each customer along with their first and last name ?

SELECT 
    c.first_name, c.last_name, total_rentals
FROM
    customer c
        INNER JOIN
    (SELECT 
        customer_id, SUM(amount) AS Total_rentals
    FROM
        payment
    GROUP BY customer_id) a ON c.customer_id = a.customer_id;



--- QUE 8) List the customers who have made more rentals than the average number of rentals made by all customers ?

SELECT 
    c.customer_id, c.first_name, c.last_name , count(c.customer_id) As total_rental
FROM
    customer c
        INNER JOIN
    rental r  ON c.customer_id = r.customer_id
    Group by  c.customer_id, c.first_name, c.last_name
    Having count(r.customer_id) > (
          select avg(rental_count)
	 FROM (
           SELECT Count(customer_id) As rental_count
     FROM
     rental
     GROUP BY customer_id
        ) b
     )
     ORDER BY Total_rental Desc;
     
     
     
--- QUE 9) Display the customer first_name , last name and email along with the names of customer living in the same city.
select * from customer; 
select * from address; 
select * from city;
SELECT 
    c.first_name, c.last_name, c.email , city.city , c2.first_name As New_first_name , c2.last_name As New_last_name
FROM
customer c
	 INNER JOIN
address a ON c.address_id = a.address_id
	  INNER JOIN
city  ON a.city_id = city.city_id
      INNER JOIN 
address a2 ON a.city_id = a2.city_id  AND a.address_id != a2.address_id
     INNER JOIN 
customer c2 ON a2.address_id = c2.address_id;



--- QUE 10)  Retrieve the film titles with a rental rate higher than a average rental rate of films in the same category ?

select title , rental_rate from film f where rental_rate > (select avg(rental_rate) from film);









--- QUE 11 ) Retrieve the film titles along with their descriptions and length that have rental rate greater than the average rental rate of films released in the same year ?

SELECT 
    f.title, f.description AS Description, f.length AS length
FROM
    film f
WHERE
    rental_rate > (SELECT 
            AVG(rental_rate)
        FROM
            film
        WHERE
            release_year = f.release_year)
            ORDER BY(length) Asc;



--- QUE 12) List the first_name , last_name and email of customers who have rented at least one film in the 'Documentary' category ?

SELECT 
   c.customer_id , c.first_name, c.last_name, c.email 
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
where c.customer_id IN (select r.customer_id 
From rental r 
        INNER JOIN 
inventory i ON r.inventory_id =i.inventory_id 
        INNER JOIN 
film_category fc ON i.film_id = fc.film_id 
      INNER JOIN 
category ca ON fc.category_id = ca.category_id 
WHERE ca.name = 'Documentry')
ORDER BY (c.customer_id) Asc;



---  QUE 13) Show the title, rental_rate and difference from the average rental_rate for each film ?

SELECT 
    film.title,
    film.rental_rate,
    (film.rental_rate - f.ren_rate) AS Difference
FROM
    film
        JOIN
    (SELECT 
        AVG(rental_rate) AS ren_rate
    FROM
        film) AS f;




--- QUE 14) Retrieve the title of films that have never been rented ?

SELECT 
    film.title
FROM
    film
WHERE
    film_id NOT IN (SELECT DISTINCT
            i.film_id
        FROM
            inventory i
                INNER JOIN
	 rental r ON i.inventory_id = r.inventory_id);
  



--- QUE 15) List the title of films whose rental_rate is higher than the average rental_rate of films released in the same year and belongs to the 'Sci-Fi' category ?

SELECT 
    film.title
FROM
    film 
			INNER JOIN 
film_category  ON film.film_id = film_category.film_id 
           INNER JOIN 
category  ON film_category.category_id = category.category_id          
WHERE rental_rate > (
select avg (film.rental_rate) 
FROM 
    film
WHERE release_year = f.release_year); 




--- QUE 16) Find the number of films rented by each customer , excluding customer who have rented fewer than 5 films ?

SELECT 
     c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS rented_films
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id 
     NOT IN (SELECT r.customer_id
        FROM
            rental r
        GROUP BY customer_id
        HAVING COUNT(rental_id) < 5)
GROUP BY c.customer_id , c.first_name
ORDER BY (rented_films)  asc;















