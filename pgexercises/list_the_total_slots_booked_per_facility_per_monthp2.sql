-- use cte and group by rollup clause
with totalcte as (
  select
  	facid,
  	extract(month from starttime) as month,
  	sum(slots) as slots
  from cd.bookings
  where extract(year from starttime) = 2012
  group by rollup(facid, month) -- can use grouping sets here: grouping sets (facid, month), (facid), ()
  order by facid, month
  )
select
	*
from totalcte;
