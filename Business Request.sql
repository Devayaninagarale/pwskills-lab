              
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

--- QUE 3) Revenue Comparison before_promo and After_promo ?

SELECT 
campaign_name AS Campaign_Name ,
concat(round(sum(base_price * `quantity_sold(before_promo)`)/1000000,2),'M')as `Revenue(Before_Promo)`,
CONCAT(ROUND(SUM(
Case
when promo_type = "BOGOF" then base_price * 0.5 * 2*(`quantity_sold(after_promo)`)
when promo_type = "50% OFF" then base_price * 0.5 * `quantity_sold(after_promo)`
when promo_type = "25% OFF" then base_price * 0.75* `quantity_sold(after_promo)`
when promo_type = "33% OFF" then base_price * 0.67 * `quantity_sold(after_promo)`
when promo_type = "500 cashback" then (base_price-500)*  `quantity_sold(after_promo)`
end)/1000000,2),'M') AS 'Revenue(after_promo)'
FROM retail_events_db.fact_events join dim_campaigns c using (campaign_id)
GROUP BY campaign_id;


--- QUE 4) Top 5 Categories by ISU% in Diwali ?

with Category1 as(
SELECT *,(if(promo_type = "BOGOF",`quantity_sold(after_promo)`* 2 ,`quantity_sold(after_promo)`)) as Qty_Sold_After
  FROM 
  fact_events fe
     INNER join
 dim_campaigns USING (campaign_id)
       inner join 
dim_products USING (product_code)
where campaign_name = "Diwali" ),

category2 as(
select 
 campaign_name, category,
((sum(Qty_Sold_After) - sum(`quantity_sold(before_promo)`))/sum(`quantity_sold(before_promo)`)) * 100 as `ISU%`
 from category1 group by category 
 )
select campaign_name, category, `ISU%`, rank() over(order by `ISU%`Desc) as `ISU%_Rank` 
from category2
group by category;
 
