select
	starttime as start,
	name
from cd.bookings
join cd.facilities using(facid)
where name like 'Tennis%' and starttime >= '2012-09-21' and starttime < '2012-09-22';
