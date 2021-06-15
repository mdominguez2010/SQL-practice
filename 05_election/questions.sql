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

select year, count(candidate)
from candidate
where year between 1984 and 2016
group by year;

--3. For each election from 1984 to 2016, give the party that won the popular vote
--(i.e. the most votes, not the most electoral college seats)
