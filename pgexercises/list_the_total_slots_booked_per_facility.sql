select
	facid,
	sum(slots) as TotalSlots
from
	cd.bookings
group by facid
order by facid;
