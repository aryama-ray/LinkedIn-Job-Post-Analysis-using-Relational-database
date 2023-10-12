# data-220-lab1-group-project
# Cleaning the company data set 
import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt
from functools import reduce
import re
import unicodedata


# import the companies table and check for its datatypes


data = pd.read_csv("companies.csv",encoding='utf-8')

for column in data.columns:
    print(f"Column: {column}, Data Type: {data[column].dtype}")


# count the number of null values and 0 values in the data


count_zero_company_id = (data['company_id'] == '0').sum()
count_null_company_id = data['company_id'].isnull().sum()

count_zero_name = (data['name'] == '0').sum()
count_null_name = data['name'].isnull().sum()

count_zero_company_size = (data['company_size'] == '0').sum()
count_null_company_size = data['company_size'].isnull().sum()

count_zero_states = (data['state'] == '0').sum()
count_null_states = data['state'].isnull().sum()

count_zero_country = (data['country'] == '0').sum()
count_null_country = data['country'].isnull().sum()

count_zero_zip_code = (data['zip_code'] == '0').sum()
count_null_zip_code = data['zip_code'].isnull().sum()

count_zero_address = (data['address'] == '0').sum()
count_null_address = data['address'].isnull().sum()

count_zero_url = (data['url'] == '0').sum()
count_null_url = data['url'].isnull().sum()

print("Counts of '0' values:")
print("Company ID:", count_zero_company_id)
print("Name:", count_zero_name)
print("Company Size:", count_zero_company_size)
print("States:", count_zero_states)
print("Country:", count_zero_country)
print("Zip Code:", count_zero_zip_code)
print("Address:", count_zero_address)
print("URL:", count_zero_url)

print("\nCounts of null (missing) values:")
print("Company ID:", count_null_company_id)
print("Name:", count_null_name)
print("Company Size:", count_null_company_size)
print("States:", count_null_states)
print("Country:", count_null_country)
print("Zip Code:", count_null_zip_code)
print("Address:", count_null_address)
print("URL:", count_null_url)


# put the non 0 values in to different dataframe so that we can calculate its mean , mode or median


data1 = data[data['state'] != '0']




data2 = data[data['country'] != '0']




data3 = data[data['zip_code'] != '0']




data4 = data[data['address'] != '0']




data5 = data[data['city']!= '0']




data.count()




# Mode of the state 
mode1 = data1['state'].mode().iloc[0]
mode1




# Replace the missing and 0 values with mode
data['state'] = data['state'].replace('0', mode1)
data['state'] = data['state'].fillna(mode1)
data




# Mode of the country 
mode2 = data2['country'].mode().iloc[0]

mode2




# Replace the missing and 0 values with mode
data['country'] = data['country'].replace('0', mode2)
data['country'] = data['country'].fillna(mode2)
data




# Mode of the zip code 
mode3 = data3['zip_code'].mode().iloc[0]
mode3




# Replace the missing and 0 values with mode
data['zip_code'] = data['zip_code'].replace('0', mode3)
data['zip_code'] = data['zip_code'].fillna(mode3)
data





# Mode of the address 
mode4 = data4['address'].mode().iloc[0]
mode4




# Replace the missing and 0 values with mode
data['address'] = data['address'].replace('0', mode4)
data['address'] = data['address'].fillna(mode4)
data




# Mode of the city 
mode5 = data5['city'].mode().iloc[0]
mode5



# Replace the missing and 0 values with mode
data['city'] = data['city'].replace('0', mode5)
data['city'] = data['city'].fillna(mode5)




count_zero_company_id = (data['company_id'] == '0').sum()
count_zero_name = (data['name'] == '0').sum()
count_zero_company_size = (data['company_size'] == '0').sum()
count_zero_states = (data['state'] == '0').sum()
count_zero_country = (data['country'] == '0').sum()
count_zero_zip_code = (data['zip_code'] == '0').sum()
count_zero_address = (data['address'] == '0').sum()
count_zero_url = (data['url'] == '0').sum()
print(count_zero_company_id)
print(count_zero_name)
print(count_zero_company_size)

print(count_zero_states)
print(count_zero_country)
print(count_zero_zip_code)
print(count_zero_address)

print(count_zero_url)



# Remove non ascii values from each column , also remove '\'',  '"'  , ','  , '' and replace with blank ''


def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['company_id'] = data['company_id'].apply(safe_normalize)
data['company_id'] = data['company_id'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['name'] = data['name'].apply(safe_normalize)
data['name'] = data['name'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['description'] = data['description'].apply(safe_normalize)
data['description'] = data['description'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['company_size'] = data['company_size'].apply(safe_normalize)
data['company_size'] = data['company_size'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['state'] = data['state'].apply(safe_normalize)
data['state'] = data['state'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['country'] = data['country'].apply(safe_normalize)
data['country'] = data['country'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['city'] = data['city'].apply(safe_normalize)
data['city'] = data['city'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['zip_code'] = data['zip_code'].apply(safe_normalize)
data['zip_code'] = data['zip_code'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['address'] = data['address'].apply(safe_normalize)
data['address'] = data['address'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)
def safe_normalize(x):
    if isinstance(x, str):
        return unicodedata.normalize('NFC', x)
    else:
        return str(x)
data['url'] = data['url'].apply(safe_normalize)
data['url'] = data['url'].apply(lambda x: re.sub(r'[^\x00-\x7F]+', '', x))
data = data.replace({'\'': '', '"': '', ',': '', '': ''}, regex=True)



# changed the data types 


data['company_id'] = data['company_id'].astype('int64')
data['name'] = data['name'].astype('string')  # Change to string data type
data['description'] = data['description'].astype('string')  # Change to string data type
data['company_size'] = data['company_size'].astype('float64')
data['state'] = data['state'].astype('string')  # Change to string data type
data['country'] = data['country'].astype('string')  # Change to string data type
data['city'] = data['city'].astype('string')  # Change to string data type
data['zip_code'] = data['zip_code'].astype('string')  # Change to string data type
data['address'] = data['address'].astype('string')  # Change to string data type
data['url'] = data['url'].astype('string')  # Change to string data type

# Check the updated data types
print(data.dtypes)


 data.to_csv('~/Documents/CleanedcompanieswithNoNull.csv',index=False, encoding = 'utf-8')







