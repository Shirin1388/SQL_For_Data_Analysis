-- Find the 3 most profitable companies in the entire world.
-- Output the result along with the corresponding company name.
-- Sort the result based on profits in descending order.

-- forbes_global_2010_2014 table
-- company:  varchar
-- sector:  varchar
-- industry:  varchar
-- continent:  varchar
-- country:  varchar
-- marketvalue:  float
-- sales:  float
-- profits:  float
-- assets:  float
-- rank:  int
-- forbeswebpage:  varchar

-- Solution (MS SQL Server): used Dense_Rank() window function
-- in this table we dont have any 2 companies with the same profits value. But in case if we have then nothing won't be missed from the top 3

select a.company, a.profit from
(
select 
     company
    ,profits as profit
    ,dense_rank() over(order by profits desc) as rank1
from forbes_global_2010_2014) as a
where a.rank1 <=3;

-- another easier solution is as below:
select top(3) company, profits from forbes_global_2010_2014
order by profits desc;
