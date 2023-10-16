# Data-225-lab1-group-project
#-------------------------------------------------------------------------------------------------------------------------#
# Input Data set 
#-------------------------------------------------------------------------------------------------------------------------#
Linkedin Job Analysis dataset contains 3 categories of dataset:
Company_details: 
     companies.csv
     company_industries.csv
     company_specialities.csv
     employee_counts.csv

job_details:
      benefits.csv
      job_industries.csv
      job_skills.csv
job_postings:
      job_postings.csv

This real world dataset was not clean. So to prepare them for import into database MySQL workbench preprocessing steps were performed.
As a part of preprocessing step job_postings.csv file is preprocessed using Jupyter notebook. 
Job posting category has one single job_posting csv file which has 15887 records and 27 columns. Since objective of our project is to analyse these data entirely on MySQL workbench platform, a databse is required to build based on these input files. To import into database, files should have correct format and datatypes. The file has null values, non ascii characters which are not readable in database,incorrect location and date columns. As a part of data preprocessing objective is to identify and correct the format and data which will enable us to import and process data in the database properly.

Following preprocessing activities were performed to clean up this dataset.

a. Checking and calculating percentage of missing values in each columns.
b. Missing value treatment- if column has greater than 80% of missing values, droping the columns. Otherwise, impute missing values with median for continuous data type. Imputing the missing values with mode for categorical data type. URL fields with null values were replaced with text 'unknown'. Removing rows where identifying row attribute i.e id column is null.
c. All string data type attributes were checked and processed for non-ascii characters and non-ascii were removed.
d. Changing all the data type in proper format compatible with database MySQL Workbench
e. File is downloaded in UTF-8 format.

ReadMe_Job_postings.ipynb has elaborated details of preprocessing of Job Postings file.
#-------------------------------------------------------------------------------------------------------------------------#
# Data Import
#-------------------------------------------------------------------------------------------------------------------------#
A staging database was created to store imported files in the Workbench.
All preprocessed data were imported into MySQL workbech staging database using Table Import Wizard and with proper format.

#-------------------------------------------------------------------------------------------------------------------------#
# Database Schema Design and insertion of Data from staging Database
#-------------------------------------------------------------------------------------------------------------------------#
A database schema was design to perform entire analysis for this project. Cardinalities and relations were identified. The database was created with normalized tables and primary key, foreign key and index fields. 
Following tables were created along with the attributes.
a. Job: This table stored job details for a company. A job can have multiple jobposts.
b. Jobpost : This table stores details regarding a jobpost posted from a company.A particular jobpost will be published from a company.
c. Benefit: This table stores details regarding benefits offered with a job. A job can offer mutiple benefits.
d. Jobskill: This table stores details regarding the skill required for a job.A job will require multiple job skills.
e. Company: This table stores details of a compnay. A company must have multiple job openings.
f. Employee_cnt: This table stores details of employee strength of a company. A company has multiple employees.
g. Comp_Spclty: This table stores details specilaity of a company. A company can have different specilities.
h. Comp_Industry: This table stores details of industry in which the company belongs.A company might belong toi different industries.

After schema design and establishing the relation, data were inserted from staging database into this working database.

#-------------------------------------------------------------------------------------------------------------------------#
# Functional Analysis and USE case diagram design
#-------------------------------------------------------------------------------------------------------------------------#
Functional Analysis requires identification of functional elements. Here we assume the database system will be accessed by two type of users. 
a. Job Seeker

A job seeker can have multiple requirements from the system.
                            
Primarily, 1. a job seeker can search for:
                                        i. a job on the platform based on skills, experience level, job title, job location, salary etc.
                                       ii. a company on the platform based on company name, company size,benefits etc.
           2. a job seeker can view and apply for a job:
                                       i. if the job post has application link posted on the platform job seeker can apply
                                       ii. if not, job seeker can view the job post via platform
b. HR Manager

An HR manager can have multiple requirements from the system.
           1. HR manager can add job post on the platform
           2. HR manager can view performance of the job post, keep track of applications on the platform
#-------------------------------------------------------------------------------------------------------------------------#
# Data Analysis based on Skill
#-------------------------------------------------------------------------------------------------------------------------#
