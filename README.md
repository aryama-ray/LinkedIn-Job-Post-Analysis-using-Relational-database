# data-220-lab1-group-project
# Job and Company Data Analysis

This repository contains SQL queries that analyze job and company data. The repository includes two primary SQL queries:

## Job View Query

The first query creates a view named Job_View, which provides information about job posts, including the number of views, job title, work type, company name, job location, and company city. The view is created using data from the JOBPOST, JOB, and COMPANY tables. It is ordered by the number of views in descending order.

## Company Sponsorship View Query

The second query creates a view named Company_Sponsorship_View, which provides details about each company, including the company ID, company name, the count of sponsored jobs, and the count of non-sponsored jobs. The view is created using data from the COMPANY and JOB tables. It is ordered by the number of sponsored jobs in descending order.

## Note:

- Please ensure that the necessary database schema and tables (JOBPOST, JOB, and COMPANY) are properly set up and populated before executing the queries.
- The views are created to simplify data analysis tasks and can be utilized for various reporting and analytical purposes.
- Make sure to understand the schema of the underlying database to interpret the results accurately.
- These SQL queries are tailored for specific data structures, so ensure they align with your data schema before execution.
- Always validate and test the queries in a safe environment before deploying them in a production setting.



