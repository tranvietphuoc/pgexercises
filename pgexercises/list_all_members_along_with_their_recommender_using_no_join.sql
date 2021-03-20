
-- join version
select distinct
	m.firstname || ' ' || m.surname as member,
	r.firstname || ' ' || r.surname as recommender
from
	cd.members m
left join cd.members r
on
	r.memid = m.recommendedby
order by member;

-- no join version (subquery)
/*
select distinct
	m.firstname || ' ' || m.surname as member,
	(select r.firstname || ' ' || r.surname as recommender
  	from cd.members r
  	where r.memid = m.recommendedby
  ) from cd.members m
  order by member;
*/
