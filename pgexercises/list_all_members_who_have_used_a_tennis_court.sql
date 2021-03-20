select distinct
	m.firstname || ' ' || m.surname as member,
	f.name as facility
from cd.members m
inner join cd.bookings b
on m.memid = b.memid
inner join cd.facilities f
on b.facid = f.facid
where f.name like 'Tennis%'
order by member, facility;

