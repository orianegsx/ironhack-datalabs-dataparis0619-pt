USE publications;

#challenge 1
SELECT authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', titles.title AS 'TITLE', publishers.pub_name AS 'PUBLISHER' 
FROM authors, titles, publishers, titleauthor
WHERE titleauthor.au_id = authors.au_id AND titleauthor.title_id = titles.title_id AND publishers.pub_id = titles.pub_id
ORDER BY authors.au_id ASC;


#challenge 1 -  Solution explicite
SELECT authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', titles.title AS 'TITLE', publishers.pub_name AS 'PUBLISHER' 
FROM titleauthor
JOIN authors
ON titleauthor.au_id = authors.au_id 
JOIN titles
ON titleauthor.title_id = titles.title_id
JOIN publishers
ON publishers.pub_id = titles.pub_id;



#Challenge 2
SELECT authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', publishers.pub_name AS 'PUBLISHER', COUNT(titles.title) AS 'TITLE' 
FROM authors, titles, publishers, titleauthor
WHERE titleauthor.au_id = authors.au_id AND titleauthor.title_id = titles.title_id AND publishers.pub_id = titles.pub_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name;


#Challenge 3
SELECT authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', SUM(sales.qty) AS 'TOTAL'
FROM authors, sales, titleauthor, titles
WHERE authors.au_id = titleauthor.au_id AND titleauthor.title_id = titles.title_id AND sales.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TOTAL DESC
LIMIT 3;


#Challenge 4
SELECT authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', IFNULL(SUM(sales.qty),0) AS 'TOTAL'
FROM authors
RIGHT JOIN titleauthor
ON authors.au_id = titleauthor.au_id 
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id 
LEFT JOIN sales
ON sales.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TOTAL DESC;


#Bonus
SELECT authors.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', SUM(titles.advance + titleauthor.royaltyper * titles.price * titles.ytd_sales/ 100) AS 'PROFIT'
FROM authors, sales, titleauthor, titles
WHERE authors.au_id = titleauthor.au_id AND titleauthor.title_id = titles.title_id AND sales.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY PROFIT DESC
LIMIT 3;



















