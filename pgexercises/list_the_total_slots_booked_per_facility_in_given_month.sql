select
	facid,
	sum(slots) as TotalSlots
from
	cd.bookings
where starttime >= date('2012-09-01') and starttime < date('2012-10-01')
group by facid
order by TotalSlots;
