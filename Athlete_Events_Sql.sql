create database project;

use project;

-- SELECT
/*The SELECT statement is used to select data from a database.*/
select * from athlete_events;

-- DISTINCT
/*The SELECT DISTINCT statement is used to return only distinct (different) values.*/
SELECT DISTINCT City FROM athlete_events;

-- INSERT INTO
/*The INSERT INTO statement is used to insert new records in a table.
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);*/

-- WHERE
/*The WHERE clause is used to filter records.
It is used to extract only those records that fulfill a specified condition*/
/*Example*/
SELECT * FROM athlete_events
WHERE City='paris';

-- SELECT * FROM project.athlete_events;

-- LOGICAL OPRATER--AND--OR
/*The AND operator displays a record if all the conditions are TRUE.
The OR operator displays a record if any of the conditions are TRUE*/
SELECT *
FROM athlete_events
WHERE City = 'PARIS' AND NAME LIKE 'D%';

SELECT * FROM project.athlete_events;

-- OPERATOR--<,>,<=,>=,=,!=
SELECT * FROM athlete_events
WHERE MEDAL < 300;

SELECT * FROM project.athlete_events;

-- ALTER
/*The ALTER TABLE statement is used to add, delete, or modify columns in an existing table.
The ALTER TABLE statement is also used to add and drop various constraints on an existing table*/

ALTER TABLE athlete_events
ADD MEDAL_TYPE VARCHAR(200);

ALTER TABLE athlete_events
DROP COLUMN MEDAL_TYPE;

SELECT * FROM project.athlete_events;



-- DELETE
/*The DELETE statement is used to delete existing records in a table.*/
-- athlete_events DELETE FROM athlete_events ;
-- 
-- DROP TABLE
/*The DROP TABLE statement is used to drop an existing table in a database*/

-- OFFSET
/*The OFFSET argument is used to identify the starting point to return rows from a result set. Basically, it exclude the first set of records.
Note:
OFFSET can only be used with ORDER BY clause. It cannot be used on its own.
OFFSET value must be greater than or equal to zero. It cannot be negative, else return error.*/
/*SELECT GAMES, SEASON
FROM athlete_events
ORDER BY year
OFFSET 1 ROWS;*/

-- ORDER BY
/*The ORDER BY keyword is used to sort the result-set in ascending or descending order.
Example*/

SELECT * FROM athlete_events
ORDER BY YEAR
limit 10 offset 1;

SELECT * FROM project.athlete_events;

-- GROUP BY
/*The GROUP BY statement groups rows that have the same values into summary rows,like 
 The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) 
 to group the result-set by one or more columns./*
 /*The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.*/

SELECT COUNT(tEAM),TEAM FROM athlete_events
WHERE SEX ="M" AND SPORT ="JUDO"
GROUP BY TEAM                                            
HAVING COUNT(TEAM)>5;

/* TOTAL NUMBER OF MALE & FEMALE ATHLETES PARTICIPATED IN Olympics  */ 
select sex, count(*) as total_no
from athlete_events
group by sex
order by sex desc;
 
/* HOW MANY GOLD MEDALS WON BY MALE & FEMALE IN OLYMPICS (9) */
select medal, sum(case when sex = "M" then 1 else 0 end) as medal_by_male, 
sum(case when sex = "F" then 1 else 0 end) as medal_by_female
from athlete_events                              
where medal = "GOLD";


/* HOW MANY SILVER MEDALS WON BY MALE & FEMALE IN Olympics (10) */
select medal, sum(case when sex = "M" then 1 else 0 end) as medal_by_male, 
sum(case when sex = "F" then 1 else 0 end) as medal_by_female
from athlete_events                              
where medal = "SILVER";

/* TOP 5 COUNTRY WON MOST BRONZE MEDALS (17) */
SELECT  Year, min(MEDAL) as medals, min(TEAM) as country, count(medal) as no_of_medal  
FROM athlete_events
where medal = "bronze" 
group by year
order by no_of_medal desc
limit 5;

SELECT * FROM project.athlete_events;

-- SUBQURREYS
/* USING SUBQURREYS
find women by id*/
SELECT sex,count(name) as Count from athlete_events  
where id in(
select ID
from athlete_events 
where TEAM = "United States")
group by sex;

SELECT sex,count(name) as Count from athlete_events  
where id in(
select ID
from athlete_events 
where sport = "Football")
group by sex;

SELECT * FROM project.athlete_events;

-- TRIGGER
/*using Trigger*/
delimiter //
 create trigger XYZ
 before delete 
 on  athlete_events
 for each row
 begin
 signal sqlstate '45000' set message_text='Not Allowed';
 end //
 delimiter //

show triggers;
 
 select * from athlete_events;

-- STROGAE PROCEDUER
/* USING STORAGE PROCEDUER*/
delimiter //
create procedure MAY ()
begin
select*
from athlete_events;
end  //
delimiter ;

call MAY();
DROP procedure ABC;
SHOW procedure status;

delimiter //
create procedure JKM(in AGE_list int,in CITY_list varchar(200))
begin
select*
from athlete_events
where AGE = AGE_list or CITY = CITY_list ;
end //
delimiter ;

call JKM(24,'UNITED STATES');

SELECT * FROM project.athlete_events;

-- CASE 
/*USING CASE STATEMENT*/
SELECT ID,NAME,CITY,AGE,
 CASE    WHEN  AGE BETWEEN 5 AND 12 THEN "KID"
         WHEN  AGE BETWEEN 13 AND 19 THEN "TEEN"
         WHEN  AGE BETWEEN 20 AND 39  THEN "ADULT"
		
ELSE "MID AGER"
END AS AGE_CATEGORY
FROM athlete_events 
ORDER BY AGE ;

SELECT * FROM project.athlete_events;


-- Transaction

set autocommit = 0;
start transaction;

commit;

delete from athlete_events
where Name  = 'Gunnar';

rollback;




/*joins
SQL Join : statement is used to combine data or rows from two or
 more tables based on a common field between them. 
 Different types of Joins are as follows: 
 /*TYPES OF JOINS
(INNER) JOIN : Returns records that have matching values in both tables
LEFT(OUTER)JOIN : Returns all records from the left table, and the matched records from the right table
RIGHT(OUTER)JOIN : Returns all records from the right table, and the matched records from the left table
FULL(OUTER)JOIN : Returns all records when there is a match in either left or right table

/*EXAMPLE/*
CREATE TABLE Athletes (
    athlete_id INT PRIMARY KEY,
    athlete_name VARCHAR(255),
    age INT,
    team VARCHAR(50));

CREATE TABLE Events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(255),
    event_year year,
    event_city VARCHAR(100));

INSERT INTO Athletes (athlete_id, athlete_name, age, team)
VALUES    
(1,'A Dijiang',24,'China')
(2,'A Lamusi',24,'China')
(3,'Gunnar Nielsen Aaby',25,'Denmark')
(4,'dgar Lindenau Aabye',25,'Denmark/Sweden')
(5,'Christine Jacoba Aaftink',26,'Netherlands')

INSERT INTO Events (event_id, event_name, event_year, event_city)
VALUES
(1,'A Dijiang',2000,'China')
(2,'A Lamusi'2004,'China')
(3,'Gunnar Nielsen Aaby',2003,'Denmark')
(4,'dgar Lindenau Aabye',2008,'Denmark/Sweden')
(5,'Christine Jacoba Aaftink',2002,'Netherlands')
*/

/*WINDOW FUNCTION--
/*Window functions applies aggregate and ranking functions over a particular window (set of rows).
 OVER clause is used with window functions to define that window. OVER clause does two things : 
//Partitions rows into form set of rows. (PARTITION BY clause is used) 
//Orders rows within those partitions into a particular order. (ORDER BY clause is used)*/ 
/*example
select id ,sex,
    sum(id) over (partition by sex) as totalmale
from athlete_events;  */  

SELECT * FROM project.athlete_events;



