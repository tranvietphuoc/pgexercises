-- use CTE
with sumcte as (
  	select
  		facid,
  		sum(slots) as totalslots
  	from cd.bookings
  	group by facid
)
select
	facid,
	totalslots
from sumcte
where totalslots = (select max(totalslots) from sumcte);
