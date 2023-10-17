# data-225-lab1-group-project

# Work Overview

This work involves cleaning and managing data related to various aspects of a company. The main components of the my work are as follows:

## Data Cleaning

The data cleaning process involved the following datasets:
- `company_industries`
- `company_specialities`
- `benefits`
- `employee_counts`

## Log Table

A log table was created along with a procedure to fill it. Three triggers were also written for each table to handle `UPDATE`, `DELETE`, and `INSERT` operations, which in turn populate the log table.

## Views and Procedures

Several views and procedures were created for different purposes:

1. **Labour Cost View**: This view, along with its associated procedure, helps the HR department understand each company's labour cost.

2. **Application View**: This view aids the HR department in understanding how many applications each company has received. It provides insights into which companies are attracting more applicants, allowing other companies to make necessary adjustments.

3. **Job Details Procedure**: This procedure takes a `job_id` as input and returns all details associated with that `job_id` and `company_id`.

4. **Delete Job Procedure**: This procedure takes a `job_id` and `company_id` as input and deletes all details associated with that `job_id`.

5. **Delete Company Procedure**: This procedure takes a `company_id` as input and deletes all details associated with that `company_id`.


Please refer to the respective SQL files for detailed information on each view and procedure.
