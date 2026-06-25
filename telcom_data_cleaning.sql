create database telco_data;

use telco_data;

-- select * from wa_fn-usec_-telco-customer-churn;

alter table telco_data.`wa_fn-usec_-telco-customer-churn`
rename telcom_table;

alter table telcom_table
rename telcom;

create table backup_table as ( select * from telcom);

select * from backup_table;

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- changing the data types of an column

alter table telcom
modify column customerID varchar(50) primary key;

alter table telcom
modify column gender varchar(20);

alter table telcom
modify column SeniorCitizen boolean;

update telcom
set Partner = case 
when Partner = 'Yes' then 1
when Partner = 'No' then 0
end ;

alter table telcom
modify column Partner boolean;

update telcom
set Dependents = case 
when Dependents = 'Yes' then 1
when Dependents = 'No' then 0
end ;

alter table telcom
modify column Dependents boolean;

update telcom
set PhoneService = case 
when PhoneService = 'Yes' then 1
when PhoneService = 'No' then 0
end ;

alter table telcom
modify column PhoneService boolean;

select * from telcom
where PhoneService = 'Yes';

update telcom
set MultipleLines = case 
when MultipleLines = 'Yes' then 1
when MultipleLines = 'No' then 0
when MultipleLines = 'No phone service' then 0
end ;

alter table telcom
modify column MultipleLines boolean;

alter table telcom
modify column InternetService varchar(30);

update telcom
set OnlineSecurity = case 
when OnlineSecurity = 'Yes' then 1
when OnlineSecurity = 'No' then 0
when OnlineSecurity= 'No internet service' then 0
end ;  --    -> changing its value into o and 1 for calculations

alter table telcom
modify column OnlineSecurity boolean; --  -> changing its data type in to boolean


update telcom
set OnlineBackup = case 
when OnlineBackup= 'Yes' then 1
else 0
end ;  --    -> changing its value into o and 1 for calculations

alter table telcom
modify column OnlineBackup boolean; --  -> changing its data type in to boolean

update telcom
set DeviceProtection = case 
when DeviceProtection= 'Yes' then 1
else 0
end ;  --    -> changing its value into o and 1 for calculations

alter table telcom
modify column DeviceProtection boolean; --  -> changing its data type in to boolean

update telcom
set TechSupport = case 
when TechSupport = 'Yes' then 1
else 0
end ;  --    -> changing its value into o and 1 for calculations

alter table telcom
modify column TechSupport boolean; --  -> changing its data type in to boolean

update telcom
set StreamingTV = case 
when StreamingTV = 'Yes' then 1
else 0
end ;  --    -> changing its value into o and 1 for calculations

alter table telcom
modify column StreamingTV boolean; --  -> changing its data type in to boolean

update telcom
set StreamingMovies = case 
when StreamingMovies = 'Yes' then 1
else 0
end ;  --    -> changing its value into o and 1 for calculations

alter table telcom
modify column StreamingMovies boolean; --  -> changing its data type in to boolean

update telcom
set PaperlessBilling = case 
when PaperlessBilling = 'Yes' then 1
else 0
end ;  --    -> changing its value into o and 1 for calculations

alter table telcom
modify column PaperlessBilling boolean; --  -> changing its data type in to boolean

update telcom
set Churn = case 
when Churn = 'Yes' then 1
else 0
end ;  --    -> changing its value into o and 1 for calculations

alter table telcom
modify column Churn boolean; --  -> changing its data type in to boolean

alter table telcom
modify PaymentMethod varchar(50);

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Doing some caluculations to find the overall customers leave

select round(sum(if(churn = 0 , 1, 0 ))/count(churn) * 100,2) as percentage_of_customers_we_have,
round(sum(if( churn = 1, 1, 0))/count(churn) * 100,2) as percentage_of_customers_leaved from telcom;

select avg(churn) * 100 from telcom;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- finding which age group of customers leaves most 


select SeniorCitizen, avg(churn) * 100 from telcom
group by SeniorCitizen;

select SeniorCitizen,Partner,Dependents, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
group by SeniorCitizen,Partner,Dependents
order by count_of_customers desc , churn_percentage desc;   


-----------------------------------------------------------------------------------------------------------------------------------------------------
-- finding the churn percentage of contract type

select Contract, avg(churn) * 100 from telcom
group by Contract;

-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Finding the security and support role is useful or not 

-- Tech support churn percentage 
select TechSupport, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by TechSupport
order by number_of_customers desc;

--  Tech support with age churn percentage
select SeniorCitizen,TechSupport, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by  SeniorCitizen, TechSupport
order by number_of_customers desc;

-- Online Security churn percentage 
select OnlineSecurity, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by OnlineSecurity
order by number_of_customers desc;

-- Online Securty with age churn percentage 
select SeniorCitizen, OnlineSecurity, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by OnlineSecurity,SeniorCitizen
order by number_of_customers desc;

-- Online backup churn percentage
select OnlineBackup, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by  OnlineBackup
order by number_of_customers desc;

-- Online backup with age churn percentage
select SeniorCitizen, OnlineBackup, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by SeniorCitizen, OnlineBackup
order by number_of_customers desc;

-- DeviceProtection churn percentage
select DeviceProtection, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by  DeviceProtection
order by number_of_customers desc;

-- DeviceProtection with age churn percentage
select SeniorCitizen, DeviceProtection, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by  DeviceProtection, SeniorCitizen
order by number_of_customers desc;

-- Steaminng Tv churn percentage
select StreamingTV, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by  StreamingTV
order by number_of_customers desc;

-- StreamingTV based on age churn percentage
select SeniorCitizen, StreamingTV, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by  StreamingTV, SeniorCitizen
order by number_of_customers desc;

-- StreamingMovies churn percentage
select StreamingMovies, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by  StreamingMovies
order by number_of_customers desc;

-- StreamingMovies based on age churn percentage
select SeniorCitizen, StreamingMovies, avg(churn) * 100 as churn_percentage, count(*) as number_of_customers from telcom
group by  StreamingMovies, SeniorCitizen
order by number_of_customers desc;

-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Month-to-Month contract, have No Tech Support, and use Paperless Billing

select Contract, avg(churn) * 100 from telcom
where TechSupport= 0 and PaperlessBilling = 1
group by contract;

-------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Finding how much customers did we lost who uses the PhoneService
  
select PhoneService, avg(churn) * 100  from telcom
group by PhoneService; --    -> lost 26 percentage of Phoneservice users 
 
select gender, avg(churn) * 100  from telcom
group by gender;  --    ->  Finding male or female customers we lost most. In this dataset we lost both of them roughly 26 percent
 
select Contract,PhoneService,MultipleLines, InternetService,avg(churn) * 100 from telcom
group by Contract,PhoneService,MultipleLines,InternetService
order by contract; 

select PaperlessBilling, avg(churn) * 100 from telcom
group by PaperlessBilling;  --  -> paparless billing customers leaving most compare to non papaerless billing customers
 
select Contract,InternetService, avg(churn) * 100 as churn_percentage from telcom
group by Contract,InternetService
order by Contract;  --  -> contract based In internetservice who has highest churn rate

-------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Finding losed customers more age based Contract type 
 
 select Contract, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
 group by Contract
 order by count_of_customers desc;
 
select Contract,SeniorCitizen,Partner,Dependents, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'Month-to-month'
group by Contract,SeniorCitizen,Partner,Dependents
order by count_of_customers desc, churn_percentage desc;  -- -> Finding age based cutomers leave most in month to month contract

select Contract,SeniorCitizen,Partner,Dependents, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'One year'
group by Contract,SeniorCitizen,Partner,Dependents
order by count_of_customers desc, churn_percentage desc;  -- -> Finding age based cutomers leave most in 1 year contract
 
select Contract,SeniorCitizen,Partner,Dependents, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'Two year'
group by Contract,SeniorCitizen,Partner,Dependents
order by count_of_customers desc, churn_percentage desc;  -- -> Finding age based cutomers leave most in 2 year contract
 
 -- In normal Contract based category i found that the month to month has the highest churn rate
 -- To Find which age of customers losed, I divide the contract category and make deep dive analyze based on age. 
 -- It showed me which place need to be focus on, In month to month is the category has highest churn rate also it describe which age of pepole I need to focus
 
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Finding customers mostly leaved in the InternetService which category 

select InternetService, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
group by InternetService
order by count_of_customers desc;  --  -> This will tell Internet service category based churn percentage

select Contract, InternetService, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'Month-to-month'
group by InternetService, Contract
order by count_of_customers desc;  --  -> This will tell Internet service month based churn percentage

select Contract,InternetService, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'One year'
group by InternetService, Contract
order by count_of_customers desc;  --  -> This will tell Internet service 1 year based churn percentage

select Contract,InternetService, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'Two year'
group by InternetService, Contract
order by count_of_customers desc;  --  -> This will tell Internet service 2 year based churn percentage


-- In this analyze i found that Internetservice fiber optic is got higher churn percentage in month to month Contract
-- second DSL got higher churn percentage in month to month Contract
-- As I found earlier, month to month has the critical churn here.
-- Like that, Internet Service fiber optic is has higher percentage of chrun in Internet Service.

select Contract,SeniorCitizen,Partner,Dependents, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'Month-to-month' and InternetService = 'Fiber optic'
group by Contract,SeniorCitizen,Partner,Dependents
order by count_of_customers desc, churn_percentage desc; -- -> this will deeply explain which age customers leaves the most in the Fiber optic categeroy by month to month

select Contract,SeniorCitizen,Partner,Dependents, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'Month-to-month' and InternetService = 'DSL'
group by Contract,SeniorCitizen,Partner,Dependents
order by count_of_customers desc, churn_percentage desc; -- -> this will deeply explain which age customers leaves the most in the Fiber optic categeroy by month to month

select Contract,SeniorCitizen,Partner,Dependents, avg(churn) * 100 as churn_percentage, count(*) as count_of_customers from telcom
where Contract = 'Month-to-month' and InternetService = 'No'
group by Contract,SeniorCitizen,Partner,Dependents
order by count_of_customers desc, churn_percentage desc; -- -> this will deeply explain which age customers leaves the most in the Fiber optic categeroy by month to month

-- I also deep down even with age in month to month customers. 
-- It showed me exactly which age customers we need to take care first.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select PaymentMethod, avg(churn) * 100 as churn_percentage, count(customerID) as customer_number from telcom
group by PaymentMethod
order by customer_number desc;

-----------------------------------------------------------------------------------------
-- Exactly at what point in the customer lifecycle do people quit?

SELECT 
    CASE 
        WHEN tenure <= 6 THEN '0-6 Months (New Joiners)'
        WHEN tenure <= 12 THEN '7-12 Months (1 Year Risk)'
        WHEN tenure <= 24 THEN '13-24 Months (1-2 Years)'
        WHEN tenure <= 48 THEN '25-48 Months (Mid-Term)'
        ELSE '48+ Months (Loyal Veterans)'
    END AS tenure_cohort,
    COUNT(customerID) AS total_customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_percentage,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_bill
FROM telcom
GROUP BY 
    CASE 
        WHEN tenure <= 6 THEN '0-6 Months (New Joiners)'
        WHEN tenure <= 12 THEN '7-12 Months (1 Year Risk)'
        WHEN tenure <= 24 THEN '13-24 Months (1-2 Years)'
        WHEN tenure <= 48 THEN '25-48 Months (Mid-Term)'
        ELSE '48+ Months (Loyal Veterans)'
    END
ORDER BY MIN(tenure) ASC;


-----------------------------------------------------------------------------------------
-- How much money is the business actively losing per month due to churn, and which contract types are responsible for the highest loss?

WITH RevenueLossCTE AS (
    SELECT 
        Contract,
        InternetService,
        COUNT(customerID) AS total_lost_customers,
        ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_lost,
        ROUND(SUM(TotalCharges), 2) AS lifetime_value_lost
    FROM telcom
    WHERE Churn = 1
    GROUP BY Contract, InternetService
)
SELECT 
    Contract,
    InternetService,
    total_lost_customers,
    monthly_revenue_lost,
    lifetime_value_lost,
    ROUND((monthly_revenue_lost / SUM(monthly_revenue_lost) OVER()) * 100, 2) AS percent_of_total_monthly_loss
FROM RevenueLossCTE
ORDER BY monthly_revenue_lost DESC;

