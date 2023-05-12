-- Problem:
-- Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. 
-- For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, 
-- consider only the latest page_load and earliest page_exit. Output the user_id and their average session time.

-- Table: facebook_web_log
-- user_id: int
-- timestamp: datetime
-- action: varchar

-- Solution: MS SQL Server

with cte1 as
(select cast(timestamp as date) as d,
    cast(timestamp as time) as t,
    user_id,
    action 
from facebook_web_log
where action in ('page_load', 'page_exit')
),
cte2 as(
select 
    d,
    datediff(second, max(Case when action = 'page_load' then t end),
        min(case when action = 'page_exit' then t end)) as diff,
    user_id
from cte1 
group by d, user_id)
select user_id, cast(AVG(diff*1.0) as decimal(6,2)) as avg_session from cte2
where diff> 0
group by user_id
