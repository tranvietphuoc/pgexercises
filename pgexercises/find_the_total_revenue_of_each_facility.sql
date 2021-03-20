create view myview as
	select f.name, sum(slots * case
					   when memid = 0 then f.guestcost
					   else f.membercost
					   end) as revenue
	from
		cd.bookings b
	inner join cd.facilities f
		on b.facid = f.facid
	group by f.name
	order by revenue;

select * from myview;
