# data-220-lab1-group-project

## Dataset Overview
The project involves the analysis of LinkedIn job data. It comprises three main categories of datasets, including company details, job details, and job postings. Preprocessing steps have been performed to ensure the data is suitable for import into a MySQL Workbench database.

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

- Preprocessed_Job_Postings.csv

The initial dataset required various corrections and preprocessing steps :

Import the job postings table and check for its data types.

Count the number of null values and 0 values in the dataset.

Extract the non-zero values into a separate dataframe for further analysis, such as mean, mode, or median calculation.

Compute the mean/mode of the columns to replace the values that are originally 0.

Replace missing values and 0 values in state, country, zip code, address, and city columns with the corresponding mode values.

Remove non-ASCII values from each column, including characters such as '', '"', and ',', replacing them with blank ''.

Eliminate the company size column, as it is not relevant to the use case and contains numerous null values.

Convert the object data types to text, which is the most suitable format for the dataset.


## SQL Queries

The repository includes SQL queries for analyzing job and company data. Two primary queries have been provided:

### Job View Query

The first query creates a view named Job_View, which provides information about job posts, including the number of views, job title, work type, company name, job location, and company city.

<img width="640" alt="111" src="https://github.com/aryama-ray/data-225-lab1-group-project/assets/144860707/4241cde7-2b5b-42a8-9bd4-552c1ceb63cf">

### Company Sponsorship View Query

The second query creates a view named Company_Sponsorship_View, which provides details about each company, including the company ID, company name, the count of sponsored jobs, and the count of non-sponsored jobs.

<img width="579" alt="222" src="https://github.com/aryama-ray/data-225-lab1-group-project/assets/144860707/5a7c44c3-78ca-4d43-92ac-a54cc8c66645">


### JMeter SQL Performance Measurement
This project focuses on utilizing JMeter for measuring the performance of SQL queries. It aims to evaluate the efficiency and scalability of SQL databases under various workloads and stress conditions. The study provides insights into query execution and database responsiveness, enabling optimization and performance enhancements.

Features:

Load testing SQL queries under diverse workloads

Assessing database performance under stress conditions

Identifying and resolving SQL query performance bottlenecks

Enhancing SQL query execution efficiency through optimization techniques

Please refer to the respective SQL and ipynb files for detailed information

![WhatsApp Image 2023-10-16 at 9 17 31 PM](https://github.com/aryama-ray/data-225-lab1-group-project/assets/144860707/f15c2a03-3339-4591-aa67-29ffa26eab89)

