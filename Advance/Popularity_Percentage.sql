-- Problem:
-- Find the popularity percentage for each user on Meta/Facebook. The popularity percentage is defined as 
-- the total number of friends the user has divided by the total number of users on the platform, then converted into a percentage by multiplying by 100.
-- Output each user along with their popularity percentage. Order records in ascending order by user id.
-- The 'user1' and 'user2' column are pairs of friends.

-- Table: facebook_friends
-- user1: int
-- user2: int

-- Solution: MS SQL Server

with cte as (
    select user1 as u, count(user2) as friends from facebook_friends
    group by user1
    union
    select user2 as u, count(user1) as friends from facebook_friends
    group by user2
)
select 
     u as user1
    ,Cast(
        (sum(friends)*1.0/
            (select count(distinct(u)) as total_users from cte))*100
            as decimal(6,3)
     ) as popularity_percent
from cte
group by u
