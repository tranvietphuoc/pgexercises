select distinct
	m2.firstname as firstname,
	m2.surname as surname
from cd.members m1
inner join cd.members m2
on
	m2.memid = m1.recommendedby
order by surname, firstname;
