select
	firstname,
	surname,
	joindate
from cd.members
where joindate >= (
  select
  	max(joindate)
  from cd.members
  );
