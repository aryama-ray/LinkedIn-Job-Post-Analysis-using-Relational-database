# data-220-lab1-group-project
# Project Title

The project involves the analysis of LinkedIn job data. It comprises three main categories of datasets, including company details, job details, and job postings. Preprocessing steps have been performed to ensure the data is suitable for import into a MySQL Workbench database.

## Dataset Overview

### Company Details:

- companies.csv
- company_industries.csv
- company_specialities.csv
- employee_counts.csv

### Job Details:

- benefits.csv
- job_industries.csv
- job_skills.csv

### Job Postings:

- job_postings.csv

The initial dataset required various corrections and preprocessing steps, including handling null values, removing non-ASCII characters that could not be interpreted in the database, and correcting the format of location and date columns.

To effectively utilize this dataset, it is crucial to set up a database based on the provided input files. Ensure the files are in the correct format and have the appropriate data types for successful importation into the database. The preprocessing steps aimed to facilitate seamless data importation and processing within the MySQL Workbench platform.

## SQL Queries

The repository includes SQL queries for analyzing job and company data. Two primary queries have been provided:

### Job View Query

The first query creates a view named Job_View, which provides information about job posts, including the number of views, job title, work type, company name, job location, and company city.

### Company Sponsorship View Query

The second query creates a view named Company_Sponsorship_View, which provides details about each company, including the company ID, company name, the count of sponsored jobs, and the count of non-sponsored jobs.

Please refer to the respective SQL and ipynb files for detailed information
