ananya
# data-220-lab1-group-project
clean the company data set since it has lot of null values , 0 values , etc

import the companies table and check for its datatypes
Count the number of null values and 0 values in the data
put the non 0 values in to different dataframe so that we can calculate its mean , mode or median
then find out the mean/mode of the columns to replace the values that have 0
Replace the missing and 0 values in state, country,zip code,address,city with mode
Remove non ascii values from each column , also remove '\'',  '"'  , ','  , '' and replace with blank ''
changed the data types for the object data types to text which is the most appropriate



Load the already processed data into different data frames, we are removing columns only from job postings , companies and benifits files

DROP Inferred data from job benifits
Drop description , zip code and address from companies 
Drop original_listed_time,expiry,listed_time,currency,expiry,compensation_type
Save the tables in csv format onto the device



# data-225-lab1-group-project
Data 225 Lab1 Group Project
main
