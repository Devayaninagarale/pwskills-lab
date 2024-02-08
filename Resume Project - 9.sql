                                  --- Business Requests ---

--- QUE 1)  Provide a list of products with a base price greater than 500 
-- And that are featured in promo type of 'BOGOF'(buy One GET One Free).
-- This information will help us identify high-value products that are currently being heavily discounted.

SELECT * FROM fact_events;
SELECT 
     distinct dp.product_code , dp.product_name, base_price , promo_type 
FROM dim_products dp
   JOIN 
fact_events fe ON dp.product_code = fe.product_code
WHERE base_price > 500 AND promo_type = 'BOGOF';



--- QUE 2) Generate a report that provides an overview of the Number_of_stores in each city.
-- The results will be sorted in descending order of store counts, 
-- Allowing us to identify the cities with the highest  store presence. 

SELECT city, COUNT(*) AS No_of_stores
FROM dim_stores
GROUP BY city
ORDER BY No_of_stores desc;


