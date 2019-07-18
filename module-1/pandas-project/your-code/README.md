#Requirements
- Download the dataSet
- Unzip it
- Add the .csv on the folder "your_code"


#STEP1: Import dataSet
- import data as csv
- read create df
- rename columns


#STEP2: Examining Data for Potential Issues
- Missing values
We will find if some columns have a lot of null value. If yes we will remove them


- Incorrect values
Define each colums and remove wrong value




- Special characters
We will analyse the set of each columns and correct data

Extreme values or outliers
- With the low variance value we will exclude some extreme value

Duplicate records
- Find duplicate rows and remove them

Incorrect data types
- Dipsplay data type of each column
- Correct data type

#STEP3: Manipulate data
- Calculate max, min, mean
- Analyse some columns (df['Column1'])
- Count some value (astronaut['Undergraduate Major'].value_counts()
- Count if value are null (df.isnull().sum(axis=0) and replace if needed (df[['ViewCount']] = df[['ViewCount']].fillna(0)

#STEP4: Export as csv
shuttle.to_csv('shuttle.csv', index=False)


