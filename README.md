# Samsung Galaxy S II experiment summarization code explanation

## Introduction

The purpose of the R code titled run_analysis.R is to create a summary of the data from an experiment measuring 
human activity using an accelerometer and a gyroscope embedded in a Samsung Galaxy S II smartphone worn on the
waists of human subjects. A more detailed description of the experiment can be found at the following URL:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The code selects the columns of the dataset containing the mean and standard deviation of each of the variables
measured in the experiment. The code then groups the data by the experiment subject and the particular activity
performed by that subject. Finally, the code produces a data summary listing the mean for each selected variable
per group within the data.

## Code explanation

The code has been broken down into twelve general steps describing what is happening as the code carries out its
programmed actions.

### Step 1

The code requires the dplyr package to function. It starts by calling dplyr from the library. If dplyr has not
been installed, it must be installed before running the code.

### Step 2

Next, the code reads the various parts of the data set into corresponding objects. This only works if the correct
directory is active as the working directory.

### Step 3

Since the data is separated into test and train sets, the code must combine them into one data frame, Fulldata, 
using cbind().

### Step 4

Now that the data has been brought together in Fulldata, the column names are assigned from a vector built using
the features file. Column names are assigned with the colnames() function.

### Step 5

To use only the data desired for the summary, the code creates two smaller data frame using only the columns which
include mean() or std(), respectively, in their column names. This is accomplished with grep().

### Step 6

The data frames including mean() and std() are combined into one data frame called Filterdata using cbind().

### Step 7

Now, the code starts the process of assigning the neccessary subject and activity labels to Filterdata. First, the 
code transforms the numeric values representing the activities performed into character strings naming the activities
using more easily recognizable names. This is accomplished through use of gsub().

### Step 8

Now, the code combines together the subject and activity identifyers for both the test and train data using cbind(),
and then combines those together into the data frame Subject_Ativity using rbind().

### Step 9

The code then creates a character vector including "Subject" and "Activity" and assigns that vector to the column
names of Subject_Activity using colnames().

### Step 10

The code then creates Filterdata_id, which combines Subject_Activity with Filterdata using cbind().

### Step 11

The code now creates groupeddata, which groups Filterdata_id by Subject and Activity.

### Step 12

The code uses summarise_each() with groupeddata to apply the mean() function to each column of groupeddata, creating
the data frame Data_Summary, which lists the mean of each variable for each of the groups by Subject and Activity.
The code then prints the data to the sceen using View(Data_Summary).

### These steps should result in the desired data set.