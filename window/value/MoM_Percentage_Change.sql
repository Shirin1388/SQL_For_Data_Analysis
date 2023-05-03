-- This example is from strataScratch website.
-- in this example I used LAG() window function to calculate previous month's revenue.
-- I also used CTE method for wrting my subqueries, this is to make the code more readable and it is easier to manage it.

-- Problem:
--Given a table of purchases by date, calculate the month-over-month percentage change in revenue.
--The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, 
--and sorted from the beginning of the year to the end of the year.
--The percentage change column will be populated from the 2nd month 
--forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.

-- sf_transactions table
-- ---------------------------------
-- |  column Name  |  column Type  |
-- ---------------------------------
-- |      Id       |      int      |
-- |   created_at  |    datetime   |
-- |     value     |      int      |
-- |  purchase_id  |      int      |
-- ---------------------------------

-- Solution (in MQ Server):

with cte as (
    select 
      format(cast(created_at as date), 'yyyy-MM') as year_month
     ,*  
    from sf_transactions
)
, monthly_rev as (
    select 
       year_month
      ,sum(value) as monthly_value
      ,lag(sum(value),1) over (order by year_month) as prv_month
    from cte
    group by year_month
)
select year_month
    ,monthly_value
    ,cast(((monthly_value - (prv_month* 1.0))/prv_month) * 100 as decimal(5,2)) as revenue_diff_pct
from monthly_rev
order by year_month
