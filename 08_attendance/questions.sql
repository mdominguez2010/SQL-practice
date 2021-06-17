-- create view combined_table as
-- select s.student_id, s.grade_level, s.date_of_birth, a.record_date, a.attended
-- from students s inner join attendance a
--     on s.student_id = a.student_id

-- attendance rate by grade_level
-- select
--     grade_level,
--     round(sum(case when attended = 't' then 1 else 0 end) * 1.00 / sum(case when attended = 't' then 1 else 1 end), 4) as attendance_rate
-- from combined_table
-- group by grade_level
-- order by attendance_rate;

-- truancy rate by day of week

select
    to_char(record_date, 'Day') as day,
    round(sum(case when attended = 'f' then 1 else 0 end) * 1.00 / sum(case when attended = 't' then 1 else 1 end), 4) as attendance_rate
from combined_table
group by 1
order by 2 desc;

