-- This example is from stratascratch wesbsite. I use AVG() window function to solve the problem

-- Problem:
-- Calculate the average session duration for each session type?

-- twitch_sessions table
-- ------------------------------------
-- |   column name   |   column type  |
-- |-----------------|----------------|
-- |      user_id    |       int      |
-- |  session_start  |     datetime   |
-- |   session_end   |     datetime   |
-- |   session_id    |       int      |
-- |  session_type   |     varchar    |
-- ------------------------------------

-- Solution (MS Sql Server):

SELECT distinct 
   session_type
  ,AVG(DATEDIFF(second, session_start, session_end)) over (partition by session_type) AS duration
FROM twitch_sessions
