/*
Erika Davis
Learn SQL from Scratch
10 July 2018
*/
/* Sections are label by the slides they represent.
Some queries are commented out because they would
ideally be run separate from other queries in their
section (e.g. where a WITH statement can only apply
to one query at a time.*/

/*1.1 Shopper funnel*/
SELECT question, COUNT(*)
FROM survey
GROUP BY 1 ORDER BY 1;

/*1.2 All responses*/
/*The below WITH statement is used with multiple queries in the 
1.2 range that are commented out by default. To activate the
queries please comment them in one at a time*/
WITH
question1 AS
	(SELECT user_id, response AS r1
  	FROM survey
   	WHERE question = "1. What are you looking for?"),

question2 AS
	(SELECT user_id, response AS r2
  	FROM survey
  	WHERE question = "2. What's your fit?"),
question3 AS
 	(SELECT user_id, response AS r3
  	FROM survey
  	WHERE question = "3. Which shapes do you like?"),
question4 AS
 	(SELECT user_id, response AS r4
  	FROM survey
  	WHERE question = "4. Which colors do you like?"),
question5 AS
 	(SELECT user_id, response AS r5
  	FROM survey
  	WHERE question = "5. When was your last eye exam?"),

all_responses AS
	(SELECT
  	question1.r1 AS style,
  	question2.r2 AS fit,
  	question3.r3 AS shape,
  	question4.r4 AS color,
  	question5.r5 AS exam
  	FROM question1
		LEFT JOIN question2
  		ON question1.user_id = question2.user_id
  		LEFT JOIN question3
  		ON question2.user_id = question3.user_id
  		LEFT JOIN question4
  		ON question3.user_id = question4.user_id
  		LEFT JOIN question5
  		ON question4.user_id = question5.user_id
	GROUP BY 1, 2, 3, 4, 5)

/*1.2.1 Unfiltered*/
/*SELECT *
FROM all_responses;*/

/*1.2.2 Style count*/
/*SELECT style, COUNT(style)
FROM all_responses
GROUP BY 1 ORDER BY 2;*/

/*1.2.3 Style vs color*/
/*SELECT color, style, COUNT(style)
FROM all_responses
GROUP BY 1, 2 ORDER BY 1;*/

/*1.2.4 Style vs fit*/
/*SELECT fit, style, COUNT(style)
FROM all_responses
GROUP BY 1, 2 ORDER BY 1;*/

/*1.2.5 Style vs shape*/
/*SELECT shape, style, COUNT(style)
FROM all_responses
GROUP BY 1, 2 ORDER BY 1;*/

/*2.1 A/B distribution*/
SELECT number_of_pairs, count(*)
FROM home_try_on
GROUP BY 1;

/*2.2 A/B purchase funnel*/
SELECT number_of_pairs, COUNT(price), ROUND(AVG(price),0)
FROM home_try_on JOIN purchase
	ON home_try_on.user_id = purchase.user_id
GROUP BY 1;

/*2.2 Color preferences*/
SELECT color, COUNT(*)
FROM quiz
GROUP BY 1;

SELECT color, COUNT(*)
FROM purchase
GROUP BY 1;

/*2.3 Quiz color vs purchase*/
SELECT quiz.color, purchase.color, COUNT(*)
FROM quiz JOIN purchase
	ON quiz.user_id = purchase.user_id
WHERE quiz.color = "Black" OR quiz.color = "Tortoise"
GROUP BY 1, 2;