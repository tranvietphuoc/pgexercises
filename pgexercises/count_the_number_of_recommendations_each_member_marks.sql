select
	recommendedby,
	count(recommendedby)
from cd.members
where recommendedby <> 0
group by recommendedby
order by recommendedby;
