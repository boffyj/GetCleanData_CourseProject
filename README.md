Course Project for Getting and Cleaning Data
============================================

This repository contains the submission for Course Project required for completing
Getting and Cleaning Data course offered by **JHBSPH**. You can access the complete
course by clicking [here](https://class.coursera.org/getdata-003).

# Analysis Summary

The main script downloads the data from the source and saves into a folder named **"data"**. Under this folder it extracts the data and used. Downloaded data was cleaned and processed to be used in further analyses. Basic steps of the processing can be listed as following:

* Train and test data were merged together.
* Only mean and standard deviations of the data were used. Averages of these values for each subject and 
each activity type were calculated and reported in the new dataset.
* Class labels and subject information were incorparated into new, tidy dataset.

More detailed information on the dataset itself, steps performed and the meaning of the variables present in the dataset can be found in the **codebook**, *CodeBook.md*.

You can find the files and their roles in this repository below:

# Files
* **run_analysis.R** - This script downloads the data, unzips and merges test and train data. Then extracts mean and standard deviations of variables and gets the average of them for each subject and each activity type. Cleaned dataset was written into a file. Each step is commented in the file. **This file is the only script file that need to be run! It performs everything automatically!**

* **CodeBook.md** - Codebook of the analysis. All details of the analysis and explanations of the dataset variables in tidy dataset can be found in this document. 

* **data** - This folder contains all the data associated with the project, except the tidied dataset. Downloaded dataset was also saved into this folder. When it's run, run_analysis.R downloads and extracts the data. In order to reduce commit size, unextracted data was removed from the repository.

* **tidyData.txt** - The result of the analysis. A new, independent tidy data set with the average of each variable for each activity and each subject. 

# Data Citation

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
