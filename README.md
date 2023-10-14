ananya
# data-220-lab1-group-project 

## Cleaning of the Companies table using jupyter notebook

clean the company data set since it has lot of null values , 0 values , etc

Import the companies table and check for its datatypes.

Count the number of null values and 0 values in the data.

Put the non 0 values in to different dataframe so that we can calculate its mean , mode or median.

Then find out the mean/mode of the columns to replace the values that have 0.

Replace the missing and 0 values in state, country,zip code,address,city with mode.

Remove non ascii values from each column , also remove '\'',  '"'  , ','  , '' and replace with blank ''.

Remove company size since it is not relavent to the use case and has lot of null values.

changed the data types for the object data types to text which is the most appropriate.

=======================================================================================================
## SQL Code for Creating and Populating Multiple Tables
### Overview
From the original tables list , we have created mock up tables with respect to our use case.
These tables include "JOB," "JOBPOST," "BENEFIT," "JOBSKILL," "COMPANY," "EMP_CNT," "COMP_INDUSTRY," and "COMP_SPCLTY." The tables are interconnected using foreign key constraints.

### Code Explanation

JOB Table Creation and Data Insertion: The code first creates a "JOB" table, which stores job-related information such as job titles, salaries, and locations. Data is inserted into this table from a source table  "job_postings."

JOBPOST Table Creation and Data Insertion: The "JOBPOST" table is created to store details about job postings, including the number of applies, views, URLs, and application types. Data is sourced from the "job_postings" table.

BENEFIT Table Creation and Data Insertion: The "BENEFIT" table is created to hold information about job benefits, associated with specific job postings. Data is inserted from a table  "benefits."

JOBSKILL Table Creation and Data Insertion: The "JOBSKILL" table is used to store job-related skills and is populated with data from the "job_skills" table.

COMPANY Table Creation and Data Insertion: The "COMPANY" table contains company details like names, locations, and URLs. Data is inserted from the "companies" table.

EMP_CNT Table Creation and Data Insertion: The "EMP_CNT" table stores data related to employee and follower counts for companies and is populated from the "employee_counts" table.

COMP_INDUSTRY Table Creation and Data Insertion: The "COMP_INDUSTRY" table is created to store information about a company's industry, and data is inserted from the "company_industries" table.

COMP_SPCLTY Table Creation and Data Insertion: The "COMP_SPCLTY" table holds data related to a company's specialties, sourced from the "company_specialities" table.

Foreign Key Constraints: The code sets up foreign key constraints between the various tables to ensure data integrity and relationships.

Usage
You can execute this SQL code in your MySQL database to create and populate these tables with data from your source tables. Make sure to adapt the table names and column mappings according to your specific data sources.

===========================================================================================
Views in a database are virtual tables that can be used to simplify complex queries and present the data in a more structured manner.

sql

CREATE VIEW `Common Benifits` AS
This SQL statement creates a new view named "Common Benefits."


sql

SELECT 
    b.type AS Benefit_Type, 
    COUNT(*) AS Popularity_Count,
    (
        SELECT c.name 
        FROM BENEFIT b2
        INNER JOIN JOB j ON b2.job_id = j.job_id
        INNER JOIN COMPANY c ON j.company_id = c.company_id
        WHERE b2.type = b.type
        GROUP BY b2.type, c.name
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS MostPopularIn 
FROM BENEFIT b
GROUP BY Benefit_Type
ORDER BY Popularity_Count DESC
LIMIT 10;



This is the SQL query that defines the logic for the "Common Benefits" view. It retrieves the most common benefits offered by companies by counting how many times each benefit type appears in the "BENEFIT" table. It also identifies the company that offers each benefit type the most. The result includes three columns: "Benefit_Type," "Popularity_Count," and "MostPopularIn."

Next,the code for a stored procedure to find internship opportunities based on user preferences:

sql
Copy code
DROP PROCEDURE IF EXISTS InternshipSP;
This SQL statement drops the stored procedure named "InternshipSP" if it already exists.

sql

DELIMITER $$

CREATE PROCEDURE InternshipSP(
    IN parameter_user_id INT,
    IN parameter_location VARCHAR(255),
    IN parameter_skillset VARCHAR(255)
)
BEGIN
This SQL code defines a stored procedure named "InternshipSP" that accepts three input parameters: "parameter_user_id," "parameter_location," and "parameter_skillset." These parameters allow users to specify their preferences for finding internship opportunities.

sql
Copy code
SELECT
    j.job_title,
    j.company_id,
    j.location,
    j.min_salary,
    j.max_salary,
    j.pay_period
FROM
    JOB j
INNER JOIN
    JOBSKILL js ON j.job_id = js.job_id
WHERE
    j.work_type = 'Internship'
    AND j.location = parameter_location
    AND js.skill = parameter_skillset
    AND j.job_id NOT IN (
        SELECT job_id FROM JOBPOST WHERE user_id = parameter_user_id
    );

END $$

DELIMITER ;

This is the body of the stored procedure. It retrieves internship opportunities based on the user's preferences. It selects job information such as job title, company ID, location, min salary, max salary, and pay period from the "JOB" table. The query filters job results based on the user's specified location and skillset, ensuring that the work type is "Internship." It also excludes jobs to which the user has already applied, identified through the "JOBPOST" table.

The statements set the end of the stored procedure definition and reset the delimiter to its default value.
