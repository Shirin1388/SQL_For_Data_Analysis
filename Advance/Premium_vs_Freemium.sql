-- Problem:
-- Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying 
-- customers have more downloads than paying customers. The output should be sorted by earliest date first, 
-- and contain 3 columns date, non-paying downloads, paying downloads.

-- TABLES:
-- ms_user_dimension
-- user_id: it
-- acc_id: int

-- ms_acc_dimension
-- acc_id: int
-- paying_customer: varchar

-- ms_download_facts
-- date: datetime
-- user_id: int
-- downloads: int

-- Solution:

with cte1 as
(select 
     user_id
    ,case when b.paying_customer = 'no' then 1 end as non_paying_user_id
    ,case when b.paying_customer = 'yes' then 1 end as paying_user_id
from ms_acc_dimension as b
inner join ms_user_dimension as a
on a.acc_id = b.acc_id)
select * from 
(
    select
        a.date
        ,sum(case 
            when b.non_paying_user_id = 1 then a.downloads end) as non_paying
        ,sum(case 
            when b.paying_user_id = 1 then a.downloads end) as paying
    from ms_download_facts as a
    inner join cte1 as b
    on b.user_id = a.user_id
    group by a.date
) as a
where non_paying > paying
order by date;
