ananya
# data-225-lab1-group-project 

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

### Mock Tables Explanation

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
## Various insights 
In the analysis_Ananya , there are various sql queries that provide insights on the tables that they can proved some analyses in respect to our requirement 

The queries provides an overview of the project, emphasizing the structured insights derived from the analysis of company, benefits, specialty, and job data. It aims to offer a comprehensive understanding of various aspects within the dataset.

Query 1: Most Common Benefits
This query aims to identify the most common benefits provided by companies and determine which company offers each benefit the most. It creates a view named "Common Benefits" that includes the benefit type, its popularity count, and the company that provides it the most. The results are sorted by popularity count in descending order.
<img width="447" alt="1 1" src="https://github.com/aryama-ray/data-225-lab1-group-project/assets/86912395/7c84212c-0515-48a6-a5a3-82780b7cfaad">

Query 2: Company's Total Count of Specialties
This query creates a view named "CompanySpecialtyCounts" to count the total number of specialties associated with each company. The results include the company name and the total count of specialties, ordered by the total specialties count in descending order.
<img width="886" alt="2 1" src="https://github.com/aryama-ray/data-225-lab1-group-project/assets/86912395/93de53da-9142-49f2-b689-db1c3f6a0152">

Query 3: Specialties of the Most Specialized Company
This query creates a view named "MostSpecializedCompanySpecialties" to list the specialties of the company with the highest count of specialties. It involves nested subqueries to find and display the specialties for the most specialized company.
<img width="1145" alt="3 1" src="https://github.com/aryama-ray/data-225-lab1-group-project/assets/86912395/1363e03a-f5dd-4b7c-ad07-a1e3ef62a582">


Query 4: Count Number of Job Posting Companies by State (US)
This query creates a view named "CompanyCountByState" to count the number of companies in each U.S. state, focusing on job posting companies. The results include the company state and the number of companies, sorted by the number of companies in descending order.
<img width="1409" alt="4 1" src="https://github.com/aryama-ray/data-225-lab1-group-project/assets/86912395/58b2384b-14a6-4da5-970c-eed1a456f1f6">

Query 5: Count of Different Work Types and Job Posting Counts
This query creates a view named "WorkTypeCount" to count the different work types offered by companies and the total job posting count for each company. The work types include part-time, full-time, internship, temporary, voluntary, and other. The results are ordered by the total job positions in descending order.
<img width="672" alt="5 1" src="https://github.com/aryama-ray/data-225-lab1-group-project/assets/86912395/0a4ef04f-15da-4f88-8e5e-611db853d240">

Stored Procedure: Internship Opportunities Based on User Preferences
This section introduces a stored procedure named "InternshipSP" designed to fetch internship opportunities based on user preferences. The procedure takes two parameters, location, and skillset. It utilizes a SELECT query to retrieve relevant job details, such as job title, company ID, location, salary details, and required skills, for internships that match the user's preferences.
An example is provided, demonstrating how to call the stored procedure with specific user inputs for location ('Los Angeles, CA') and skillset ('EDU').

<img width="1113" alt="SP" src="https://github.com/aryama-ray/data-225-lab1-group-project/assets/86912395/89c233ef-8ea4-42c5-862a-1ced8bf552b0">
