CREATE DATABASE SQL_ASSIGNMENT_2
USE SQL_ASSIGNMENT_2

select * from jomato


--1.Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.

-- TVF 
create function chicken()
returns table 
as
return 
select replace(restauranttype , 'Quick Bites' , 'Quick Chicken Bites' ) as 'RESTAURAUNT TYPE'
from jomato

--UDF

Create FUNCTION ChickenStuff (@inputString VARCHAR(MAX))

RETURNS VARCHAR(MAX)

AS

BEGIN

    DECLARE @result VARCHAR(MAX)

    SET @result = STUFF(@inputString,7, 7, 'Chicken bites')

    RETURN @result

END



SELECT dbo.Chickenstuff('Quick Bites')



SELECT * FROM DBO.chicken()

--2. Use the function to display the restaurant name and cuisine type which has the
--maximum number of rating.

create function cusines_restaurants()
returns table
as 
return select restaurantname as 'RESTAURANT NAME' , cuisinestype AS 'CUISINE TYPE' from
jomato where no_of_rating >= (select max(no_of_rating) from jomato)


select * from dbo.cusines_restaurants()



--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4 
--start rating, ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3
--and below 3.5 and ‘Bad’ if it is below 3 star rating.

select * ,
case 
when rating > 4 then 'excellent'
when rating > 3.5 and rating < 4 then 'good'
when rating > 3 and rating <3.5 then 'average'
else 'bad'
end as 'RATING STATUS'
FROM jomato




--4. Find the Ceil, floor and absolute values of the rating column and display the current date
--and separately display the year, month_name and day.



select * , 
CEILING(rating) as 'CEILING' ,
FLOOR(RATING) AS 'FLOOR' ,
ABS(RATING) AS 'ABSOLUTE' , 
GETDATE() as 'CURRENT DATE' ,
YEAR(GETDATE()) AS 'YEAR' ,
DATENAME(MONTH , GETDATE()) AS 'MONTH' ,
DAY(GETDATE()) AS 'DAY'
from jomato



--5. Display the restaurant type and total average cost using rollup

select restauranttype , 
sum(averagecost) as 'AVERAGE COST'
from jomato 
group by rollup(RestaurantType)




