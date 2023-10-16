# data-225-lab1-group-project

# Work Overview

The work consists of 2 main components, preprocessing of few of the tables of the LinkedIn Dataset and it contains a set of SQL triggers designed to assist in database maintenance and monitoring for a job posting system. The triggers are designed to handle various scenarios, such as archiving jobs with a high number of applications, expiring old job postings, and handling low-interest jobs. Additionally, there are triggers to log and notify HR when salary changes occur in job listings.

## Table of Contents

- [Data Cleaning](#data-cleaning)
- [Table Structure](#table-structure)
- [Archiving High-Interest Jobs](#archiving-high-interest-jobs)
- [Expiring Old Job Postings](#expiring-old-job-postings)
- [Handling Low-Interest Jobs](#handling-low-interest-jobs)
- [Logging Salary Changes](#logging-salary-changes)
- [Notifying HR of Salary Changes](#notifying-hr-of-salary-changes)

## Data Cleaning

The data cleaning process involved the following datasets:
- `benefits`
- `company_industries`
- `company_specialities`

## Table Structure

### Database Tables
1. `JOBPOST`: The main table that stores job postings.
2. `JOB`: The main table that stores job postings.
3. `archive_table`: An archive table for storing high-interest jobs.
4. `trigger_logs`: A logging table to track events.
5. `notifications`: A table for notifications.
6. `salary_change_logs`: A table to log minimum salary changes.
7. `salary_change_logs_max`: A table to log maximum salary changes.

## Archiving High-Interest Jobs

- **Trigger Name**: `archive_job_trigger`
- **Functionality**: This trigger archives jobs with more than 200 applications. It moves the job posting to the `archive_table`, logs the event, and sends a notification to HR.
- **Conditions**: Triggered before an update on `JOBPOST` when the number of applications (`NEW.applies`) is greater than or equal to 200.

## Expiring Old Job Postings

- **Trigger Name**: `expire_job_trigger`
- **Functionality**: This trigger archives job postings that have been active for more than 30 days.
- **Conditions**: Triggered before an update on `JOBPOST` when the `NEW.post_date` is older than 30 days compared to the current date.

## Handling Low-Interest Jobs

- **Trigger Name**: `low_interest_jobs`
- **Functionality**: This trigger archives jobs with less than or equal to 5 applications that have been active for more than 10 days.
- **Conditions**: Triggered before an update on `JOBPOST` when the number of applications (`NEW.applies`) is less than or equal to 5 and the job's `post_date` is older than 10 days compared to the current date.

## Logging Salary Changes

- **Trigger Name**: `log_salary_changes`
- **Functionality**: This trigger logs minimum salary changes in the `salary_change_logs` table when a job listing's `min_salary` is updated.
- **Conditions**: Triggered after an update on `JOB` when the `OLD.min_salary` is different from the `NEW.min_salary`.

- **Trigger Name**: `log_salary_changes_max`
- **Functionality**: This trigger logs maximum salary changes in the `salary_change_logs_max` table when a job listing's `max_salary` is updated.
- **Conditions**: Triggered after an update on `JOB` when the `OLD.max_salary` is different from the `NEW.max_salary`.

## Notifying HR of Salary Changes

- **Trigger Name**: `salary_change_notify`
- **Functionality`: This trigger sends a notification to HR when a job listing's `min_salary` is updated.
- **Conditions**: Triggered before an update on `JOB` when the `OLD.min_salary` is different from the `NEW.min_salary`.

- **Trigger Name**: `salary_change_notify_max`
- **Functionality**: This trigger sends a notification to HR when a job listing's `max_salary` is updated.
- **Conditions**: Triggered before an update on `JOB` when the `OLD.max_salary` is different from the `NEW.max_salary`.

These triggers enhance database management and monitoring for a job posting system, helping maintain data integrity, archive high-interest jobs, and notify HR of critical changes.

Please refer to the respective SQL and ipynb files for detailed information on each processes.
