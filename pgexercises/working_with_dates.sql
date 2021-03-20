select
	memid,
	surname,
	firstname,
	joindate
from cd.members
where joindate > date('2012-09-01');
