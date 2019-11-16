#!/usr/bin/env python
# coding: utf-8

# # Machine learning pipline

# ## Import dataset and explore data

# In[8]:


import numpy
from sklearn import datasets, utils
from sklearn.model_selection import cross_val_score
import pandas.io
from sklearn import tree, pipeline, preprocessing
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import chi2
from sklearn.externals import joblib
from sklearn import preprocessing
from sklearn.preprocessing import LabelEncoder


# In[86]:


patients = pandas.read_csv('data.csv')
patients.head()


# In[88]:


patients.shape


# In[87]:


patients.dtypes


# We have to drop the id column because it is not an interesting/impacting value

# In[89]:


patients.isnull().sum()


#  The column 'Unamed: 32' should also be drop because of null values

# ## Create a pipeline

# In[84]:


#
# DECLARATION PART
#
PIPELINEPATH= "ser_pipeline.pickle"
DATASETPATH= "data.csv"


# We create our dataframe from our .csv and we remove 'id' and 'Unnamed: 32' columns
# We also encode the diagnosis column
def readCsvToDataFrame(path):
    theDataFrame= pandas.read_csv(path)
    le = LabelEncoder()
    theDataFrame['diagnosis'] = le.fit_transform(theDataFrame['diagnosis'])
    theDataFrame = theDataFrame.drop('id',axis=1)
    theDataFrame = theDataFrame.drop('Unnamed: 32',axis=1)
    return theDataFrame


# We print info on our dataframe
def show_df_info(dataframe):
    # get the data type
    print(type(dataframe))
    print("amount of entries is %s" % dataframe.size)
    print("dimensions= %i" % dataframe.ndim)
    print("shape is ", end="")
    print(dataframe.shape)
    print("axes: ", end="")
    print(dataframe.axes)
    print("data types of columns:")
    print(dataframe.dtypes)
    print("features: %s" % dataframe.columns)


#We split the dataframe in two part
def sliceDataFrame(df):
    return df.iloc[:, 1:], df.iloc[:, 0]


#
# PROGRAM BODY
#

## PHASE 1: LOAD DATASET
dataset= readCsvToDataFrame(DATASETPATH)
show_df_info(dataset)
print(dataset.head(5))


## PHASE 2: SLICE DATASET
training_instances, class_labels= sliceDataFrame(dataset)

show_df_info(training_instances)
# preview the data
print(training_instances.head(5))
print()
print(class_labels.head(5))


## PHASE 3: CREATE PIPELINE
cart_model= tree.DecisionTreeClassifier()
pipe= pipeline.Pipeline(steps=[("feature_selection", SelectKBest(chi2, k=8)), ("scale", preprocessing.StandardScaler()),  ("CART", cart_model)])

## PHASE 4: TRAIN
# fit all stages of the pipeline
pipe.fit(training_instances, y=class_labels)

## PHASE 5: EVALUATE
# return value is array of scores
scores = cross_val_score(pipe, training_instances, class_labels, cv=5)
# use as quality metric the average CV score
meanCvAccuracy= scores.mean()
print("Mean CV accuracy= %f" % meanCvAccuracy)

## PHASE 6: SAVE PIPELINE
# the whole pipeline in one single file
joblib.dump(pipe, PIPELINEPATH, compress = 1)

## PHASE 7: LOAD THE PIPELINE
# read the file and deserialize the pipeline
pipeline_loaded = joblib.load(PIPELINEPATH)

## PHASE 8: CLASSIFY NEW INSTANCES
# create new random problem instance
vector= numpy.random.uniform(low=0, high=1, size=(30,))
print(vector)
result= pipeline_loaded.predict([vector,])
print("class label is %i" % result)

print("--- end of execution ---")


# In[ ]:




