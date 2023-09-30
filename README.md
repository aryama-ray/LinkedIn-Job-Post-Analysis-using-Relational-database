# data-220-lab1-group-project
Data 220 Lab1 Group Project
#data processing for companies 


import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt
from functools import reduce

data = pd.read_csv("companies1.csv",encoding='utf-8')

for column in data.columns:
    print(f"Column: {column}, Data Type: {data[column].dtype}")
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

