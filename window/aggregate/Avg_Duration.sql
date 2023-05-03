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

select
  AVG(session_end - session_start) over (partition by session_type) as avg_duration
from twitch_sessions
