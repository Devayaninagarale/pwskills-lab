use h1b_visa;

--- QUE 1) Chceking the count of rows ?
SELECT COUNT(*) FROM h1b_data;

--- QUE 2) Check data_values ?
select * from h1b_data limit 5;

--- QUE 3) Check data_type ?
describe h1b_data;


--- QUE 4) Convert the data_type and data_values of Wage column
update h1b_data set WAGE_RATE_OF_PAY_TO = case
when WAGE_RATE_OF_PAY_FROM = "" then Null else
cast(replace(replace(WAGE_RATE_OF_PAY_FROM, "$" ,""), "," , "") as decimal(10,2))
end; -- case when condition then true else false end

SELECT cast(replace(replace("$61,000.00","$",""),"," ,"")as decimal(10,2));


--- QUE 5) Check null_value in table ?
SELECT case_number , case when WAGE_RATE_OF_PAY_TO is null then 1 end from h1b_data;


--- QUE 6) Checking for Duplicates Values ?
SELECT case_number, count(*) from h1b_data group by case_number having count(*) > 1;


--- QUE 7) CHECKING FOR MISSING VALUES
SELECT COUNT(*), COUNT(CASE WHEN CASE_NUMBER IS NULL THEN 1 END) AS NULL_COUNT FROM h1b_data;


-- Views
create view h1b_data_part1 as 
select CASE_NUMBER ,
CASE_STATUS ,
RECEIVED_DATE , 
DECISION_DATE  ,
ORIGINAL_CERT_DATE ,
VISA_CLASS ,
JOB_TITLE ,
SOC_CODE ,
SOC_TITLE ,
FULL_TIME_POSITION ,
BEGIN_DATE ,
END_DATE FROM h1b_data limit 1000;


Create view agent_view as
select AGENT_REPRESENTING_EMPLOYER ,
AGENT_ATTORNEY_LAST_NAME ,
AGENT_ATTORNEY_FIRST_NAME ,
AGENT_ATTORNEY_MIDDLE_NAME,
AGENT_ATTORNEY_ADDRESS1 ,
AGENT_ATTORNEY_ADDRESS2 ,
AGENT_ATTORNEY_CITY
From h1b_data limit 10;


--- QUE 8) Convert data_values and the data_type in correct format 
select * from h1b_data;
UPDATE H1B_DATA
SET RECEIVED_DATE = STR_TO_DATE(RECEIVED_DATE, '%m/%d/%Y');

UPDATE H1B_DATA
SET ORIGINAL_CERT_DATE = STR_TO_DATE(ORIGINAL_CERT_DATE, '%m/%d/%Y');

UPDATE h1b_data
SET DECISION_DATE = STR_TO_DATE(DECISION_DATE,'%m/%d/%Y');

UPDATE H1B_DATA
SET BEGIN_DATE = STR_TO_DATE(BEGIN_DATE,'%m/%d/%Y');

UPDATE h1b_data 
SET END_DATE = STR_TO_DATE(END_DATE,'%m/%d/%Y');



--- QUE 9) Reterive different Visa_classes from h1b_data ?
SELECT DISTINCT(VISA_CLASS) 
 FROM h1b_data;

--- QUE 10) Retreive the AGENT_ATTORNEY_FIRST_NAME , LAST_NAME and email_address having ".net" in Email ?
select AGENT_ATTORNEY_FIRST_NAME , AGENT_ATTORNEY_LAST_NAME, AGENT_ATTORNEY_EMAIL_ADDRESS 
from h1b_data
WHERE AGENT_ATTORNEY_EMAIL_ADDRESS LIKE "%.NET"
Order by AGENT_ATTORNEY_FIRST_NAME;


--- QUE 11) Retrieve the latest decision date among all H1B visa petitions ?
SELECT MAX(DECISION_DATE) As latest_date
FROM h1b_data
order by latest_date;


--- QUE 12) Retreive Name were EMPLOYER_POC_FIRST_NAME has 'e' in there First_name and EMPLOYER_COUNTRY "UNITED STATES OF AMERICA" ?
SELECT EMPLOYER_POC_FIRST_NAME , EMPLOYER_COUNTRY
FROM h1b_data
where EMPLOYER_POC_FIRST_NAME LIKE '%e%' 
AND EMPLOYER_COUNTRY = "United States of America";


--- QUE 13) Retrieve the rows were the Employer_country do_not_match the Employer_POC_country ?
Select EMPLOYER_COUNTRY , EMPLOYER_POC_COUNTRY
FROM h1b_data
WHERE EMPLOYER_COUNTRY != EMPLOYER_POC_COUNTRY;


--- QUE 14) Reterive Number_of petitions with respective of their Uniuqe Visa_classes from h1b_data ?
SELECT VISA_CLASS , count(VISA_CLASS) As No_of_petitions
FROM h1b_data
group by VISA_CLASS
order by No_of_petitions;


--- QUE 15) Retrieve the Employer_names and maximum_wages(WAGE_RATE_OF_PAY_TO) for H1B visa petitions where maximum_wage_rate is between $56,181 and $70,325 ?
SELECT  EMPLOYER_NAME , WAGE_RATE_OF_PAY_TO
FROM h1b_data
where WAGE_RATE_OF_PAY_TO BETWEEN 56181.00 and  70325.00
GROUP BY Employer_name , WAGE_RATE_OF_PAY_TO 
Order by WAGE_RATE_OF_PAY_TO Desc;
 
 
--- QUE 16) Retrive the Begin_DATE from H1B Visa without any repetition of dates ?
SELECT DISTINCT BEGIN_DATE
FROM H1B_DATA;
 
 
 --- QUE 17) Retrive CASE_STATUS with_respective their result from H1B Visa without repetition ?
SELECT DISTINCT CASE_status , count(case_status) as Case_Result
FROM H1B_DATA
GROUP BY CASE_STATUS;

 
--- QUE 18) How many Employers have the word "Consulting" in their name?
SELECT EMPLOYER_NAME 
FROM h1b_data 
WHERE EMPLOYER_NAME LIKE '%Consulting%'
ORDER BY Employer_Name;


--- QUE 19) Which Job_title seem to pay the Minimum_wages ?
SELECT Job_title ,
    MIN(WAGE_RATE_OF_PAY_FROM) AS Minimun_Wages
FROM 
     h1b_data
GROUP BY JOB_TITLE
ORDER BY Minimun_Wages DESC;


--- QUE 20) Retrieve data_were how many H1B visa petitions in the dataset have been Approved?
SELECT  CASE_STATUS, Count(*) as Data_Appproved
FROM h1b_data
WHERE CASE_STATUS = "Certified"
GROUP BY CASE_STATUS;


--- QUE 21)Which are the top 5 Employers_state 'CA' in a certain industry ?
-- you are looking for job title as 'Data Analysts' in Texas 

SELECT Employer_name, COUNT(*) AS Total_entities
FROM h1b_data
WHERE Employer_state = 'CA'  
AND JOB_TITLE = 'Data Analyst'
GROUP BY Employer_name
ORDER BY Total_entities DESC
LIMIT 5;


--- QUE 22) Which Job_title seem to pay the most? 
SELECT Job_title,
      MAX(WAGE_RATE_OF_PAY_FROM) AS Max_Wages
FROM
    h1b_data
GROUP BY Job_title
ORDER BY Max_Wages Desc;


--- QUE 23) Find the Number_of_petitions filed for the state of 'New York' ?
SELECT Worksite_state,
     COUNT(*) AS Number_of_petitions
FROM 
    h1b_data
WHERE WORKSITE_STATE = 'NY'
group by worksite_state
ORDER BY Number_of_petitions desc;
 
 
--- QUE 24) Implement a ranking_system_for Employers based on the total_number_of_petitions filed h1b visa?
WITH Employer_ranking as(
SELECT Employer_Name ,  count(*) as total_number_of_petitions , 
RANK() Over(order by count(*) desc) as Employer_rank
FROM h1b_data 
GROUP BY EMPLOYER_NAME
)
SELECT
Employer_Name , total_number_of_petitions , Employer_rank
FROM Employer_ranking
order by Employer_rank;

--- QUE 25) Create a list of unique concatenated Names(first_name, Last_name) for employer_poc_data As Full_Name ?
SELECT EMPLOYER_POC_FIRST_NAME , EMPLOYER_POC_LAST_NAME ,
concat(EMPLOYER_POC_FIRST_NAME , " " , EMPLOYER_POC_LAST_NAME) as Full_Name
FROM h1b_data;






