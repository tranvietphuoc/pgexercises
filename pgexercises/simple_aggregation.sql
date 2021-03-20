/*
select
	joindate
from
	cd.members
order by joindate desc
limit 1;
*/
-- aggregate
select max(joindate) as latest
from cd.members;
