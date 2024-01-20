    -- First Normal Form (1NF)
--- QUE 1) Identify a table in the Sakila database that violates 1NF. 
-- Explain how you would normalize it to achieve 1NF
 
 SELECT * FROM actor_award;
 -- Considering the "actor_award" table, which violates the First Normal Form (1NF) based on the assumption as it stores multiple values in a single column. 
 -- Here is simplified example of the "actor_award" table :

actor_award_id |  actor_id  |    awards  
----------------------------------------------
    1          |     12     | Emmy,Oscar,Tony
    2          |     21     | Emmy,Oscar,Tony
    3          |     51     | Emmy,Oscar,Tony
    4          |     125    | Emmy,Oscar,Tony

In this example, the 'awards' column appears to contain multiple values (awards) separated by commas. 
Which violates the 1NF rule, as each cell should contain one_value for each.

To normalize the 'actor_award' table abd achieve 1NF,
you can create_new_table for 'awards'. Lets say new_table as awards_Table and 
establish relationship between actor_award table & awrads_Table using intermediate_table 
 
actor_award Table:
actor_award_id |  actor_id    
-----------------------------
	  1        |   12         
      2        |   21         
	  3        |   51       
      4        |   125        


awards Table :
awards_id |   awards  
------------------------
   1     |   Emmy         
   2     |   Oscar        
   3     |   Tony      
     
 
actor_award_awards Table :
actor_award_id |  awards_id    
------------------------------
	  1        |    1         
      1        |    2        
	  1        |    3       
      2        |    1    
      2        |    2        
	  2        |    3  
-- By doing this,you normalize the data and ensure that each column contains atomic values.
-- Which follows the process of First Normal Form (1NF).



	 -- Second Normal Form (2NF)
 --- QUE 2) Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
 -- If it violates 2NF, explain the steps to normalize it ?
 
 SELECT * FROM payment;
-- In this example, the payment table includes columns such as customer_id, staff_id, and rental_id.
-- To determine whether the table is in Second Normal Form (2NF) , we need to check for partial dependencies.
 
 --- Partial_dependency_Check
--  Identify if any attributes depend on only a part of the primary key.
 In this case, 'amount' depends only on "rental_id", and "payment_date" depends on "payment_id".
 These dependencies suggest a violation of 2NF.
 
 payment_id | customet_id | staff_id | rental_id | amount | payment_date
-----------------------------------------------------------------------------
    1       |     1       |     1     |   76     |  2.99  | 2005-05-25
	2       |     1       |     1     |  573     |  0.99  | 2005-05-28
    3       |     1       |     1     |  1185    |  5.99  | 2005-06-15
    4       |     1       |     2     |  1422    |  0.99  | 2005-06-15
    5       |     1       |     2     |  1185    |  9.99  | 2005-06-15

 --- Steps to Normalize :
1) Identify the redundancy we want to remove data_repetation 
2) Establish relationships between the tables.
 
Normalized 'payment_details' table:
payment_id | rental_id | amount | payment_date
--------------------------------------------------
   1      |  76        | 2.99   | 2005-05-25
   2      |  573       | 0.99   | 2005-05-28
   3      |  1185      | 5.99   | 2005-06-15
   4      |  1422      | 0.50   | 2005-06-15
   5      |  1185      | 9.99   | 2005-06-15


Normalized 'payment_customer' table:
 payment_id | customet_id 
-----------------------------
    1       |     1      
	2       |     1      
    3       |     1      
    4       |     1     
    5       |     1      

Normalized 'payment_staff' table:
 payment_id |satff_id 
---------------------------
    1       |     1      
	2       |     1      
    3       |     1      
    4       |     2     
    5       |     2
    
In this normalization, 
1)  payment_details table has information directly related to payments
2)  payment_customer table has information related to payment & customer
3)  payment_staff table has information reltaed to payment & staff.
4)  This separation ensures that each table has a clear and independent purpose, reducing redundancy and improving the overall database structure.
    
 
    -- Third Normal Form (3NF)
--- QUE 3)  Identify a table in Sakila that violates 3NF. 
-- Describe the transitive dependencies present and outline the steps to normalize the table to 3NF

emp table:
emp_id | emp_name       | manager_id
----------------------------------------
1      | John Doe       | Null
2      | Alice Smith    | 1
3      | Bobby Johnson  | 1
4      | Charlie Brown  | 2
5      | Evan Gracia    | 2

Steps to Normalize to 3NF:
1) Create a 'manager' table: As in sakila database their is no Mangaer table
manager_id | manager_name
----------------------------
    1      | Maria Chan
    2      | Carol Wong
    
2) Modify the emp table:
emp_id | emp_name       | manager_id
----------------------------------------
1      | John Doe       | Null
2      | Alice Smith    | 1
3      | Bobby Johnson  | 1
4      | Charlie Brown  | 2
5      | Evan Gracia    | 2

Now, the emp_table is in 3NF. The manager_id column is no longer transitively dependent on the emp_id because it directly references the primary key of the manager table.



    -- Normalization Process
--- QUE 4) Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF
    
SELECT * FROM emp;
--- In "emp" table has column such as emp_id , emp_name , manager_id 

-- Initial Unnormalized Form (emp table):
emp_id | emp_name       | manager_id
---------------------------------------
1      | John Doe       | Null
2      | Alice Smith    | 1
3      | Bobby Johnson  | 1
4      | Charlie Brown  | 2
5      | Evan Gracia    | 2

-- Steps to Normalize to 1NF:
1) Identify atomic values in each column: 
In this table, all columns seem to contain atomic values, and there are no multiple values present.

2) Identify a primary key: 
The emp_id column is a primary key as it uniquely identifies each employee.
 Now, table is in First Normal Form (1NF).
 
  -- Steps to Normalize to 2NF: 
1) Identify partial dependencies:
Check if there are partial dependencies.
-- In this table, there is a potential partial dependency. The manager_id column is dependent on the emp_id, which is part of the primary key. 
-- Create new table for 'Manager'.

2) Create 'manager' table:
 manager_id | manager_name
-----------------------------
    1       |  Maria Chan
    2       |  Carol Wong


3) Modify the emp table:
emp_id | emp_name       | manager_id
----------------------------------------
1      | John Doe       | Null
2      | Alice Smith    | 1
3      | Bobby Johnson  | 1
4      | Charlie Brown  | 2
5      | Evan Gracia    | 2

-- This separation ensures that each table has a clear and independent purpose. 
-- reducing redundancy and improving the overall database structure.



    -- CTE Basics
--- QUE 5) Write a query using a CTE to receive the distinct list of actor_names and the number_of _films they have acted in from the actor and film_actor table ?
WITH films_acted AS (
    SELECT
        a.actor_id, CONCAT(first_name," ", last_name) as actor_name,
        COUNT(fa.film_id) AS film_count
    FROM
        actor a
    JOIN
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id 
)
SELECT
    actor_name , film_count
FROM
   films_acted
order BY actor_name;
   


    -- Recursive CTE
--- QUE 6) Use a recursive CTE to generate a hierarchail list of categories and their sub-categories from category table in sakila database ?
WITH recursive hierarchail_list(h) as (
;





	-- CTE with Joins
--- QUE 7) Create a CTE that combines information from the film and language tables to display film_tile , language name & rental rate ?

WITH Combined_info as (
SELECT title , l.name as language_name , rental_rate
FROM film f
    INNER JOIN
language l ON f.language_id = l.language_id
)
SELECT 
  title , language_name , rental_rate
FROM 
  combined_info
ORDER BY rental_rate;


-- CTE for Aggregation
--- QUE 8)Write a query using a CTE to find the total revenue generated by each customer(sum of payments) from the customer and payment table ?
WITH Revenue as (
SELECT c.customer_id , 
   CONCAT(first_name,"  ", last_name) as full_name,
   SUM(p.amount) as revenue_generated
FROM customer c
      INNER JOIN 
payment p ON c.customer_id = p.customer_id
group by c.customer_id  , full_name
)
SELECT 
    customer_id , full_name , revenue_generated
FROM 
   Revenue
ORDER BY revenue_generated desc;



 -- CTE with Window Functions
--- QUE 9)Utilize a CTE with a window function to rank films based on their rental duration from the film table ?

WITH ranked_films as (
SELECT film_id , title ,  rental_duration , 
rank() over (order by rental_duration) as ranking
FROM film 
group by film_id , title 
)
SELECT
 film_id , title , rental_duration , ranking 
FROM 
 ranked_films
ORDER BY ranking;


-- CTE and Filtering
--- QUE 10) Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer detail ? 

WITH customer_list as (
SELECT c.customer_id , 
concat(first_name , " " , last_name)as customer_name ,
COUNT(rental_id) as rental_counts
FROM rental r
      INNER JOIN 
customer c ON c.customer_id = r.customer_id
GROUP BY customer_id
having count(rental_id) > 2
) 
SELECT 
    customer_id , customer_name , rental_counts
FROM customer_list;



    -- CTE for Date Calculations
--- QUE11) Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table ?

WITH total_rentals as (
SELECT extract(MONTH FROM rental_date)as rental_month_count , 
 COUNT(rental_id) AS rental_counts
FROM rental 
GROUP BY rental_month_count
)
SELECT 
  rental_month_count , rental_counts
FROM total_rentals
ORDER BY rental_counts;



    -- CTE for Pivot Operations
--- QUE 12) Use a CTE to pivot the data from the payment table to display the total_payments made by each customer in separate columns for different payment methods ?
    
WITH payment_method as (
SELECT customer_id, 
  COUNT(amount) as total_payments, 
  COUNT(distinct(amount)) as diff_pay_methods
FROM payment  
    GROUP BY
        customer_id 
)
SELECT
    customer_id, total_payments ,diff_pay_methods
FROM payment_method
ORDER BY diff_pay_methods;
   
   
   

   -- CTE and Self-Join
--- QUE 13) Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the  film_actor table ?

WITH same_movies as (
SELECT fa.film_id, 
fa.actor_id as actor_id,
fa1.actor_id as actor1_id,
COUNT(distinct(fa.film_id)) as film_apperared_together
FROM 
   film_actor fa
     JOIN 
film_actor fa1 ON fa.film_id = fa1.film_id  AND fa.actor_id <  fa1.actor_id 
GROUP BY fa.actor_id , fa1.actor_id , fa.film_id
)
SELECT actor_id , actor1_id , film_id , film_apperared_together
FROM same_movies;






