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
In the analysis_Ananya , there are various sql queries that provide insights on the tables that they can proved some analyses in repect to our requirement 

Views:
1. Common Benefits View:
This view (Common Benefits) aggregates information about benefits from a table named BENEFIT. It lists the distinct benefit types along with their popularity count and the most popular company associated with each benefit type.
2. Company Specialty Counts View:
This view (CompanySpecialtyCounts) counts the total number of specialties associated with each company.
3. Most Specialized Company Specialties View:
This view (MostSpecializedCompanySpecialties) lists the specialties of the company with the highest count of specialties.
4. Company Count By State View:
This view (CompanyCountByState) counts the number of companies in each U.S. state.

Certainly! Below is an explanation of the provided SQL script, which includes the creation of views and a stored procedure:

Views:
1. Common Benefits View:
This view (Common Benefits) aggregates information about benefits from a table named BENEFIT. It lists the distinct benefit types along with their popularity count and the most popular company associated with each benefit type.

2. Company Specialty Counts View:
This view (CompanySpecialtyCounts) counts the total number of specialties associated with each company.

3. Most Specialized Company Specialties View:
This view (MostSpecializedCompanySpecialties) lists the specialties of the company with the highest count of specialties.

4. Company Count By State View:
This view (CompanyCountByState) counts the number of companies in each U.S. state.

5. Work Type Count View:
This view (WorkTypeCount) counts the different work types offered by companies and the total job posting count.

6. Internship Stored Procedure:
This stored procedure (InternshipSP) retrieves internship opportunities based on user preferences. It takes two parameters (p_location and p_skillset) and returns relevant job details for internships matching the specified criteria.
