select
	starttime
from cd.bookings
join cd.members using(memid)
where firstname || ' ' || surname = 'David Farrell';
