#step1
SELECT authors.au_id AS 'AUTHOR ID', titles.title_id AS 'TITLE ID', SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'PROFIT'
FROM authors, sales, titleauthor, titles
WHERE authors.au_id = titleauthor.au_id AND titleauthor.title_id = titles.title_id AND sales.title_id = titles.title_id
GROUP BY authors.au_id, titles.title_id 

#Step2
SELECT authors.au_id AS 'AUTHOR ID', titles.title_id AS 'TITLE ID', SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'PROFIT'
FROM authors
RIGHT JOIN titleauthor
ON authors.au_id = titleauthor.au_id 
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id 
LEFT JOIN sales
ON sales.title_id = titles.title_id
GROUP BY authors.au_id, titles.title_id
ORDER BY PROFIT DESC;


#step3
SELECT authors.au_id AS 'AUTHOR ID', SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'PROFIT'
FROM authors, titleauthor, titles, sales
WHERE authors.au_id = titleauthor.au_id AND titleauthor.title_id = titles.title_id AND sales.title_id = titles.title_id
GROUP BY authors.au_id
ORDER BY PROFIT DESC;


CREATE TABLE most_profiting_authors AS (SELECT authors.au_id AS 'au_id', SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'profits' FROM authors, titleauthor, titles, sales
WHERE authors.au_id = titleauthor.au_id AND titleauthor.title_id = titles.title_id AND sales.title_id = titles.title_id
GROUP BY authors.au_id);
