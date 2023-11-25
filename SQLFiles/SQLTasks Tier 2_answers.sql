/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */
SELECT f.name
FROM Facilities AS f
WHERE f.membercost!=0

/* Q2: How many facilities do not charge a fee to members? */
SELECT COUNT(f.name)
FROM Facilities AS f
WHERE f.membercost=0

/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT f.name
FROM Facilities AS f
WHERE f.membercost!=0 AND f.membercost<0.20*f.monthlymaintenance

/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */
SELECT *
FROM Facilities AS f
WHERE f.facid IN (1,5)

/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */
SELECT f.name,f.monthlymaintenance,f.expense_label
FROM Facilities AS f


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */
SELECT m.firstname,m.surname
FROM Members AS m
WHERE m.joindate=(SELECT MAX(m.joindate) FROM Members AS m)
/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
SELECT f.name, CONCAT(m.firstname,' ',m.surname) AS fullname
FROM Facilities AS f
INNER JOIN Members AS m
ON m.memid=f.facid
WHERE f.name LIKE 'Tennis Court%' 
ORDER BY fullname

/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */


WITH CTE AS (
  SELECT CONCAT(m.firstname,' ',m.surname) AS fullname, m.memid FROM Members AS m
  WHERE memid!=0
   )
SELECT CTE.fullname,f.name,f.membercost
FROM CTE
INNER JOIN Bookings as b
ON CTE.memid=b.memid 
INNER JOIN Facilities AS f
		ON b.facid=f.facid
WHERE DAY(b.starttime) = 14 AND MONTH(b.starttime) = 09 AND YEAR(b.starttime) = 2012 AND f.membercost<30
ORDER BY f.membercost DESC
/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SELECT CONCAT(m.firstname,' ',m.surname) AS fullname, combine.name,combine.membercost
FROM Members AS m
INNER JOIN
(SELECT f.name,f.membercost,b.memid
FROM Facilities AS f
INNER JOIN Bookings AS b
ON b.facid=f.facid
WHERE DAY(b.starttime) = 14 AND MONTH(b.starttime) = 09 AND YEAR(b.starttime) = 2012 AND f.membercost<30
ORDER BY f.membercost DESC) AS combine
ON m.memid=combine.memid
WHERE m.memid!=0


/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  

QUESTIONS:
##import sqlite
import os
import sqlite3
os.getcwd()

#Read in the country_club sql database
with open("Documents/Course/Datascience/SQLFiles/country_club.sql", 'r') as sql_file:
    sql_script = sql_file.read()

db = sqlite3.connect('Documents/Course/Datascience/SQLFiles/sqlite_db_pythonsqlite.db')
cursor = db.cursor()
sql_query = """SELECT name FROM sqlite_master  
  WHERE type='table';"""
cursor.execute(sql_query)
print(cursor.fetchall())


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */


cursor.execute("""SELECT f.name, f.initialoutlay FROM Facilities AS f WHERE f.initialoutlay<1000 ORDER BY f.initialoutlay""").fetchall()


/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */

cursor.execute("""
SELECT m1.firstname, m1.surname,m1.recommendedby AS recommender, m2.firstname AS recommender_firstname, m2.surname AS recommender_lastname
FROM Members AS m1
LEFT JOIN Members AS m2
ON m1.recommendedby=m2.memid
WHERE m1.surname!='GUEST' AND m2.surname IS NOT NULL
ORDER BY m2.surname, m2.firstname""").fetchall()

/* Q12: Find the facilities with their usage by member, but not guests */

cursor.execute("""SELECT f.name,COUNT(b.memid) FROM Facilities AS f
LEFT JOIN Bookings AS B ON f.facid=b.facid WHERE b.memid!=0 GROUP BY b.memid""").fetchall()


/* Q13: Find the facilities usage by month, but not guests */

cursor.execute("""SELECT 
f.name,STRFTIME("%m", b.starttime) AS month,COUNT(b.memid)
FROM Facilities AS f
LEFT JOIN Bookings AS b
ON f.facid=b.facid WHERE b.memid!=0 GROUP BY month""").fetchall()