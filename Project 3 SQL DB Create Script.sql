/*
CUNY MSDA 607 Project 3 Spring 2016
Fully Normalized Relational SQL Database Script

1. Creates a new schema called ds_skills
2. Creates the required normalized tables (5 in total)
3. Provide sample insert statements using test data for all tables

NEXT STEPS: Queries need to be written that construct "tidy" versions of the
document / skills data

NOTE: This schema may be modified if new data requirements are uncovered during the
data exploration work that is currently underway.

*/

DROP SCHEMA IF EXISTS ds_skills;
CREATE SCHEMA ds_skills;
USE ds_skills;

/* --------------------------------------------------------------*/

DROP TABLE IF EXISTS doc_skills;
DROP TABLE IF EXISTS skill_type;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS doc_category;

/******************************************************************

Create a table that tracks different categories of source documents, eg, Twitter, Url, etc.

******************************************************************/

CREATE TABLE doc_category
(
  dc_id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  dc_cat varchar(30) NOT NULL
);

/*** Populate energycategories table with 2 categories ***/
/* NOTE: the dc_id primary key automatically increments with each new 
insert statement */

INSERT INTO doc_category ( dc_cat ) 
VALUES 
('Twitter'),
('URL');

SELECT * FROM doc_category;

/*****************************************************************

Create a table called documents that tracks the names/paths of source documents

******************************************************************/

DROP TABLE IF EXISTS documents;

CREATE TABLE documents
(
  doc_id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  dc_id int NOT NULL,
  doc_path varchar(200) NOT NULL,
  doc_title varchar(150), /* if we can scrape from URL or twitter data */
  CONSTRAINT dc_id
    FOREIGN KEY (`dc_id`)
    REFERENCES `doc_category` (`dc_id`)
);

/* Insert Test data taken from Kishore's URL list */

INSERT INTO documents ( dc_id, doc_path, doc_title ) 
VALUES 
(2,
 'http://www.kdnuggets.com/2014/11/9-must-have-skills-data-scientist.html', 
 'Must-Have Skills You Need to Become a Data Scientist'),

(2, 
 'https://www.quora.com/What-are-the-most-valuable-skills-to-learn-for-a-data-scientist-now',
 'What are the most valuable skills to learn for a data scientist ?'),

(2, 
  'http://dataconomy.com/top-10-data-science-skills-and-how-to-learn-them/',
  'The Top 10 Data Science Skills, and How to Learn Them');


/* query to check valid results of inserts */
SELECT * FROM documents;


/******************************************************************

Create a table that tracks different skill categories e.g., 'technical', 'soft'

******************************************************************/
DROP TABLE IF EXISTS skill_category;

CREATE TABLE skill_category
(
  sc_id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  skill_cat varchar(50) NOT NULL
);

INSERT INTO skill_category ( skill_cat ) 
VALUES 
('Technical'),
('Soft');

SELECT * FROM skill_category;

/******************************************************************

Create a table that tracks different skill names, eg, 'R', 'SQL', etc..

******************************************************************/
DROP TABLE IF EXISTS skills;

CREATE TABLE skills
(
  skill_id int AUTO_INCREMENT PRIMARY KEY NOT NULL,
  sc_id int NOT NULL,
  skill_name varchar(50) NOT NULL,
  CONSTRAINT sc_id
    FOREIGN KEY (`sc_id`)
    REFERENCES `skill_category` (`sc_id`)
);


/* Insert Test data taken from Kishore's skills list */
INSERT INTO skills ( sc_id, skill_name ) 
VALUES 
(1, 'Python'),
(1, 'R'),
(1, 'Linear Algebra'),
(2, 'Collaborative'),
(2, 'Adaptability');

/* query to check validity of inserts */
SELECT * FROM skills;


/*****************************************************************

Create a table called doc_skills that facilitates a 
many-to-many relationship between tables 'documents' and 'skills'

******************************************************************/
DROP TABLE IF EXISTS doc_skills;

CREATE TABLE doc_skills
(
  doc_id int REFERENCES documents.doc_id,
  skill_id int REFERENCES skills.skill_id,
  ds_freq int NOT NULL
);

/* Insert Test data taken from sample inserts done above
   for skills and documents tables and a contrived frequency for the document*/

INSERT INTO doc_skills ( doc_id, skill_id, ds_freq ) 
VALUES 
(1, 4, 5),
(1, 2, 3),
(2, 2, 6),
(2, 5, 7),
(3, 3, 2);doc_category

/* query to check validity of inserts */
SELECT * FROM doc_skills;