update cd.facilities f
set
	membercost = (select membercost*1.1 from cd.facilities where name = 'Tennis Court 1'),
	guestcost = (select guestcost*1.1 from cd.facilities where name = 'Tennis Court 1')
where
	f.name = 'Tennis Court 2';
