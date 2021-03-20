
/*
 *
-- top 10 location have largest total cases of covid
-- using fetch clause
select location, sum(total_death) as deaths
from covid
group by location
having sum(total_death) is not NULL
order by deaths desc
-- limit 20 offset 1;
offset 0 row
fetch next 100 row only; -- the same with limit clause
*/

/*
 * from -> where -> group by -> having -> select -> distinct -> order by -> limit
 */


/*
 * -- limit clause example
select location, sum(total_death) as deaths
from covid
group by location
having sum(total_death) is not null
order by deaths asc
limit 100;
*/



/*
-- grouping sets example
 -- group by clause
select iso_code, location, sum(total_case) cases
from covid
group by
	grouping sets (
		(iso_code, location),
		(iso_code),
		(location),
		()
	)
having sum(total_case) > 3000000
order by cases desc
--offset 0 row
--fetch next 20 row only;
 */

/*
-- grouping() function example
select
	grouping(iso_code) grouping_code,
	grouping(location) grouping_location,
	iso_code,
	location,
	sum(total_case) cases
from covid
group by
	grouping sets (
		(iso_code, location),
		(iso_code),
		(location),
		()
	)
order by cases desc;
*/

-- rollup clause is a subclause of group by clause that offers a shorthand for defining multiple grouping sets
-- Different from the CUBE subclause, ROLLUP does not generate all possible grouping sets based on the specified columns.
-- It just makes a subset of those.
/*
select
	iso_code,
	location,
	sum(total_case)
from
	covid
group by
	rollup(iso_code, location)
order by
	iso_code,
	location
limit 30;
*/

/*
select
	extract (year from date) y,
	extract (month from date) m,
	extract (day from date) d,
	count(iso_code)
from covid
group by
	rollup (
		extract (year from date),
		extract (month from date),
		extract (day from date)
	);
*/

-- cube is subclause of group by to generate multiple grouping sets
/*
select
	iso_code,
	location,
	sum(total_case) cases
from covid
group by
	cube(iso_code, location)
order by cases desc;
*/

/*
 -- we can perform a partial cube to reduce the number of aggregates calculated.
select
 	iso_code,
 	location,
 	sum(total_case) cases
 from covid
group by
	--iso_code,
	cube(iso_code, location)
order by cases desc;
*/

/*
-- using with subquery
select
 	iso_code,
 	location,
 	sum(total_case) cases
 from covid
group by
	--iso_code,
	cube(iso_code, location)
having sum(total_case) > (
	select avg(total_case)
	from covid
)
order by cases desc;
-- exists operator return true if the subquery returns any row
*/

/*

select code, date_time
from saoke
where content like '%TAI KHO%' or content like '%tai kho%'
group by
grouping sets(
	(code, date_time)
)
order by date_time;
*/

-- any operator examples - any is synonym with some operator - any operator must be preceded by comparison operators
-- the subquery of any operator mus return exactly 1 column
-- any operator must return true if any values of subquery meets the condition, else it returns false.
-- = any is equivalent with in operator
-- <> any is equivalent with not in operator
/*
select code, amount from saoke
where amount = any(
	select max(amount)
	from saoke
	group by code);

select code, amount from saoke
where amount >= any(
    select avg(amount)
    from saoke
    group by code
);
*/

-- all operator examples
-- all operator must be preceded by comparison operators
-- all operator return true if all values of subquery meets the condition, else it returns false.
-- in case the subquery return no row, then all operator always evalutes to true.
/*
select
	code, amount
from saoke
where amount >= all(
	select max(amount)
	from saoke
	group by code
);
*/

-- exists operator examples
-- exists is a boolean operator that tests for the existence of rows in a subquery
-- exists operator return true if the subquery return at least on row, else, it returns false
-- exists operator is often used with the correlated query
-- if the subquery return NULL, then the exixts operator return true
-- the result of exists depends on whether any row returned by the subquery, not row contents
/*
 SELECT
    column1
FROM
    table_1
WHERE
    EXISTS( SELECT
                1
            FROM
                table_2
            WHERE
                column_2 = table_1.column_1);
*/
-- recursive query using common table expressions
/*
with recursive test as (
	select
		date_time,
		code,
		content,
		amount
	from
		saoke
	where content like '%TAI KHO%' or content like '%tai kho%'
	union
		select
			s.date_time,
			s.code,
			s.content,
			s.amount
		from
			saoke s
		inner join test t on t.code = s.code
)select
	*
from
	test;
*/

/*
 *
select date_time, code, sum(amount) sum_debit
from saoke
group by
	date_time, code
order by date_time;
*/
-- postgresql upsert using insert on conflict
-- the idea is that when you insert a new row, postgres will update
-- if it already exists, otherwise, it will insert the new row.

insert into employees (employee_id, full_name, manager_id)
values (21, 'Tran Phuoc', 5)
on conflict (employee_id)
do
	update set full_name = excluded.full_name || ';' || employees.full_name;

-- Window functions:
-- A window function performs a calculation across a set of table rows
-- that are somehow related to the current row. This is comparble to the type of
-- calculation that can be done with an aggregate function.
-- A window function call always contain OVER clause directly following
-- the window function's name and arguments. This is syntaxtically distinguishes it from
-- a normal function or non-window aggregate.
