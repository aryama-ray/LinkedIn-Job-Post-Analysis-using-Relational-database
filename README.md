# Database Management and Data Cleaning - Readme

This readme provides a detailed explanation of every component within the database management and data cleaning project.

## Data Cleaning

The data cleaning process involved the following datasets:

- `company_industries`
- `company_specialities`
- `companies`
- `Job`
- `Job Post`
- `Jon Skills`
- `benefits`
- `employee_counts`

### Data Cleaning Steps

1. **Null Values Handling**: Null values in the datasets were addressed by examining each column and deciding whether to impute or drop the data. Columns with more than 80% null values were dropped. Otherwise, missing values were imputed. Median values were used for continuous data types, while mode values were used for categorical data types.

2. **Non-ASCII Characters Removal**: String data types were examined for non-ASCII characters. These non-ASCII characters, which could hinder database compatibility, were removed from the data.

3. **Data Type Adjustment**: The data types of the columns were adjusted to be in the most appropriate format for database compatibility. This included transforming object data types into text data types.

4. **Special Characters Handling**: Special characters such as single quotes ('), double quotes ("), and commas (,) were removed and replaced with blank spaces for data consistency.

5. **Company Size Removal**: The "company size" column, which was not relevant for the use case and contained many null values, was removed from the dataset.

6. **UTF-8 Format**: Data was saved in UTF-8 format for uniform encoding and compatibility.

## Log Table and Triggers

A log table was created to maintain a record of database changes, and triggers were implemented for each table to capture `UPDATE`, `DELETE`, and `INSERT` operations and populate the log table with relevant information.

### Log Table Structure

The log table includes the following columns:

- `log_id`: A unique identifier for each log entry.
- `table_name`: The name of the table on which the action was performed.
- `action_type`: The type of action (INSERT, UPDATE, DELETE).
- `action_time`: The timestamp when the action occurred.

### Triggers

1. **Archive Job Trigger**

A trigger named archive_job_trigger moves jobs from the JOBPOST table to an archive_table when the number of applications (applies) for a job exceeds 200.

2. **Triggers with Notification and Logging**

Two tables, trigger_logs and notifications, are involved. The archive_job_trigger not only moves the record but also logs the event in trigger_logs and sends a notification through the notifications table.

3. **Job Expiry and Low-Interest Triggers**

Two other triggers named expire_job_trigger and low_interest_jobs move jobs to the archive_table based on conditions such as post date and low application numbers.

4. **Salary Change Triggers**

Triggers for logging minimum and maximum salary changes (log_salary_changes and log_salary_changes_max) have been implemented. These triggers populate the salary_change_logs table whenever there are changes in salaries.

5. **Notifications for Salary Changes**

Triggers salary_change_notify and salary_change_notify_max send notifications to the HR department when there are changes in the minimum and maximum salaries.


## Views and Procedures

Several views and procedures were created to facilitate data analysis and management.

1. **Labour Cost View and Procedure**: The "Labour Cost View" provides insights into the labour cost associated with each company. The associated procedure fetches and calculates the labour cost based on employee counts and salary data, aiding in financial planning.

2. **Application View**: This view provides insights into the number of job applications received by each company. This information is essential for HR departments to assess the success of their recruitment efforts.

3. **Job Details Procedure**: The procedure retrieves all details associated with a specific job ID. This aids in retrieving job-specific information quickly.

4. **Delete Job Procedure**: This procedure is designed to delete all details associated with a specific job. It provides a way to remove outdated job postings from the database.

5. **Delete Company Procedure**: This procedure allows the deletion of all details associated with a specific company. It facilitates data management for company profiles.

6. **Archived Table and Procedure**: An archived table was created to store details of job postings that have been removed from the main table. A procedure was written to facilitate the archiving process.

## Repository Structure

This repository contains SQL scripts and files related to the data cleaning process, triggers, views, and procedures. Together, these components create a comprehensive solution for managing company and job posting data, making it more organized and accessible for analysis and database management.



