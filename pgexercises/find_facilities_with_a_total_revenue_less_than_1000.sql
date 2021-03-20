
/*
select name, revenue
from (
  select
	f.name,
	sum(case
		when memid = 0 then b.slots * f.guestcost
		else b.slots * f.membercost
	   	end) as revenue
from cd.bookings b
inner join cd.facilities f
	on b.facid = f.facid
group by f.name
order by revenue) as agg
where agg.revenue < 1000;
*/
select
	f.name,
	sum(b.slots * case
		when b.memid = 0 then f.guestcost
		else f.membercost
		end) as revenue
from
	cd.bookings as b
inner join cd.facilities f
	on b.facid = f.facid
group by name
having sum(b.slots * case
		   when b.memid = 0 then f.guestcost
		   else f.membercost
		   end) < 1000
order by revenue;
