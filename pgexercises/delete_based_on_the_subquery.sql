delete from cd.members
where memid not in (
  select
  	b.memid
  from cd.bookings b
  );
