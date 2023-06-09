-- problem:
-- Find the 3-month rolling average of total revenue from purchases given a table with users, 
-- their purchase amount, and date purchased. 
-- Do not include returns which are represented by negative purchase values. 
-- Output the year-month (YYYY-MM) and 3-month rolling average of revenue, 
-- sorted from earliest month to latest month.

-- A 3-month rolling average is defined by calculating the average total revenue from all user purchases 
-- for the current month and previous two months. The first two months will not be a true 3-month rolling 
-- average since we are not given data from last year. Assume each month has at least one purchase.

-- Table: amazon_purchases
-- ---------------------------------
-- |  column name  |  column type  |
-- ---------------------------------
-- |    user_id    |       int     |
-- |   created_at  |    datetime   |
-- |  purchase_amt |       int     |
-- ---------------------------------

-- Solution (MS SQL Server): I used aggregare window function AVG()

with cte as (
    select 
         format(cast(created_at as date), 'yyyy-MM') as year_month
        ,sum(purchase_amt) as value
    from amazon_purchases
    where purchase_amt >0
    group by format(cast(created_at as date), 'yyyy-MM')
)
select
     year_month
    ,cast(avg(value*1.0) 
        over(order by year_month rows between 2 preceding and current row) as decimal(10,2)) as three_months_avg_purchase_value
from cte
order by year_month
