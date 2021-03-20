select distinct
	surname
from cd.members
order by surname
fetch next 10 rows only;
