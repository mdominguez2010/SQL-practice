-- clean up the table
-- CREATE VIEW tidy_election AS (
--     (select state, democrat_votes AS votes, 'democrat' as party, year from election)
--     union
--     (select state, republican_votes as votes, 'republican' as party, year from election)
--     union
--     (select state, other_votes as votes, 'other' as party, year from election)
--     order by 1, 4
-- );

--1. How many candidates are in the candidate table for the 2000 election?

-- select count(candidate) as n_candidates from candidate where year = 2000;
-- select candidate from candidate where year = 2000;

--2. How many candidates are in the candidate table for each election from 1984 to 2016?

-- select year, count(candidate)
-- from candidate
-- where year between 1984 and 2016
-- group by year;

--3. For each election from 1984 to 2016, give the party that won the popular vote
--(i.e. the most votes, not the most electoral college seats)

-- select year, total_democrat, total_republican, total_other,
--     case
--         when total_democrat > total_republican then 'democrat'
--         when total_republican > total_democrat then 'republican'
--         else 'other'
--         end as winner
-- from
-- (select
--     year,
--     sum(democrat_votes) as total_democrat,
--     sum(republican_votes) as total_republican,
--     sum(other_votes) as total_other
-- from election
-- where year between 1984 and 2016
-- group by year
-- order by year) as sum_table

--4. Extension of previous question: for each election from 1984 to 2016,
--give the party that won the popular vote and the margin
--(i.e. the amount that the winning party got over the party that came in second place)

-- select year, total_democrat, total_republican, abs(total_democrat - total_republican) as margin,
--     case
--         when total_democrat > total_republican then 'democrat'
--         when total_republican > total_democrat then 'republican'
--         else 'other'
--         end as winner
-- from
-- (select
--     year,
--     sum(democrat_votes) as total_democrat,
--     sum(republican_votes) as total_republican,
--     sum(other_votes) as total_other
-- from election
-- where year between 1984 and 2016
-- group by year
-- order by year) as sum_table

--5. Which states have had fewer than 3 democratic victories
--(i.e. fewer than 3 elections where the democrats got the majority of the votes in that state) since 1952?

-- with state_winners as
-- (select year, state, total_democrat, total_republican, abs(total_democrat - total_republican) as margin,
--     case
--         when total_democrat > total_republican then 'democrat'
--         when total_republican > total_democrat then 'republican'
--         else 'other'
--         end as winner
-- from
-- (select
--     year,
--     state,
--     sum(democrat_votes) as total_democrat,
--     sum(republican_votes) as total_republican,
--     sum(other_votes) as total_other
-- from election
-- where year >= 1952
-- group by year, state
-- order by year, state) as sum_table)

-- select
--     state,
--     count(winner) as num_dem_wins
-- from state_winners
-- where winner = 'democrat'
-- group by state
-- having count(winner) < 3;

--6. Which states have had fewer than 3 republican victories since 1952?

-- with state_winners as
-- (select year, state, total_democrat, total_republican, abs(total_democrat - total_republican) as margin,
--     case
--         when total_democrat > total_republican then 'democrat'
--         when total_republican > total_democrat then 'republican'
--         else 'other'
--         end as winner
-- from
-- (select
--     year,
--     state,
--     sum(democrat_votes) as total_democrat,
--     sum(republican_votes) as total_republican,
--     sum(other_votes) as total_other
-- from election
-- where year >= 1952
-- group by year, state
-- order by year, state) as sum_table)

-- select
--     state,
--     sum(case when winner = 'democrat' then 1 else 0 end) as num_democrat_wins,
--     sum(case when winner = 'republican' then 1 else 0 end) as num_repub_wins
-- from state_winners
-- group by state
-- having sum(case when winner = 'republican' then 1 else 0 end) < 3

--7. We are interested in measuring the partisanship of the states.
-- We will define a partisan state as one that is consistently won
-- by a single party (either Democrat or Republican) since 1988.
-- For example, since 1988 California has been won by the republicans once,
-- and won by the democrats 7 times. Under this metric,
-- California would be considered "partisan".
-- (Note that if we include elections back to 1952, the republicans have won CA 9 times,
-- and democrats have only won it 8 times).

-- with state_winners as
-- (select year, state, total_democrat, total_republican, abs(total_democrat - total_republican) as margin,
--     case
--         when total_democrat > total_republican then 'democrat'
--         when total_republican > total_democrat then 'republican'
--         else 'other'
--         end as winner
-- from
-- (select
--     year,
--     state,
--     sum(democrat_votes) as total_democrat,
--     sum(republican_votes) as total_republican,
--     sum(other_votes) as total_other
-- from election
-- where year >= 1988
-- group by year, state
-- order by year, state) as sum_table),

-- num_party_wins_by_state as 
-- (select
--     state,
--     sum(case when winner = 'democrat' then 1 else 0 end) as num_democrat_wins,
--     sum(case when winner = 'republican' then 1 else 0 end) as num_repub_wins
-- from state_winners
-- group by state)

-- select
--     state,
--     case
--         when num_democrat_wins = 0 then 'republican'
--         when num_repub_wins = 0 then 'democrat'
--         else 'other'
--         end as partisanship
-- from num_party_wins_by_state
-- where 
--     case
--         when num_democrat_wins = 0 then 'republican'
--         when num_repub_wins = 0 then 'democrat'
--         else 'other'
--         end = 'republican'
--     or
--     case
--         when num_democrat_wins = 0 then 'republican'
--         when num_repub_wins = 0 then 'democrat'
--         else 'other'
--         end = 'democrat'
-- order by 2, 1

--- sliding window functions
-- with total_votes_table as
-- (select
--     year,
--     sum(democrat_votes + republican_votes) as total_votes
-- from election
-- group by year
-- order by 2 DESC)

-- select
--     year,
--     total_votes,
--     sum(total_votes) over(order by total_votes) as rolling_sum,
--     avg(total_votes) over(order by total_votes) as rolling_avg
-- from total_votes_table;

-- sliding window functions with filters
-- count number of states who won each party per year plus candidate name
with summary_table as
(select
    state,
    year,
    case
        when democrat_votes > republican_votes then 'democrat'
        when republican_votes > democrat_votes then 'republican'
        else 'other'
        end as winner
from election),

select
    year,
    sum(case when winner = 'democrat' then 1 else 0 end) as num_democrat_states,
    sum(case when winner = 'republican' then 1 else 0 end) as num_repub_states
from summary_table
group by 1
order by 1
