
# Predicting Parkinson Disease metrics UPDRS scores at a given time point using protein and peptide data 
# 1. Data
**The data has been downloaded from a kaggle competition using [kaggle](https://www.kaggle.com/competitions/amp-parkinsons-disease-progression-prediction/data.)
The  data had  248 patients with protein measurements (NPX values) for 234 proteins and peptide abundances for 968 peptides. The data was collected across 0,6,12 and 24 months, with all time points not available for each patient. UPDRS scores from 1-4 at each visit month and the up23db_clinical_state on medication was available. The protein, peptide abundances and clinical data were in separate files.
# 2. Data cleaning
Look at code [here](https://github.com/mt98/Datascience/blob/06301f45273ce34637a670a0347f6e65a961d626/Second_capstone/Capstone_two_1-Data_wrangling.ipynb)
In this Repo I explored the three separate files available: protein, peptide abundances and clinical data. The UPDRS scores were imputed with median values upon missing values and we observed a differences in the median UPDRS scores with the minimum visit month difference.

<img width="502" alt="Screen Shot 2024-08-11 at 7 56 51 PM" src="https://github.com/user-attachments/assets/ea8cd43d-37c9-4ff1-9b7e-2001ef54d061">

We combined the protein and peptide abundance files together to make a new file and also saved the cleaned clinical dataset. 

# 3. EDA

We log2 transformed the protein NPX values and the peptide abundance values so they have a normal distribution.
<img width="329" alt="Screen Shot 2024-08-11 at 8 02 06 PM" src="https://github.com/user-attachments/assets/4d10cbc4-a78d-45cf-a472-d94370100056">

We wanted to reduce the number of protein and peptide abundance values which could be used to predict the UPDRS scores. However, the correlations of the UPDRS scores with the Protein NPX values and Peptide abundance values were poor.

<img width="1012" alt="Screen Shot 2024-08-12 at 7 33 30 PM" src="https://github.com/user-attachments/assets/63bd32ed-4077-47b2-a489-cde4211d1a69">



# 4. Preprocessing
We split the dataset 80 to 20 into training and testing dataset. We had to encode the features . The protein and peptide abundances which are continuous features were scaled, while up23db_clinical_state on medication which was a categorical variable was one hot encoded. We used the Boruta method for feature selection for each of the UPDRS scores. Boruta works by creating shadow features of the actual features and tests whether the features perform better than these random shadow features. 
The selected features for each of the UPDRS scores were chosen for the modeling steps.

# 5.Modeling
Initially we modeled the training dataset to predict the UPDRS scores. We tried two methods a decision tree classifier based method: lightgbm and SVM. The table below shows that for each of the UPDRS scores, there was a poor performance for RMSE for both lightgbm and SVM with the RMSE's being much higher than 10% of the mean. The negative sign can be ignored as it is used by scikitlearn to ensure higher values are better models.

<img width="407" alt="Screen Shot 2024-08-12 at 7 03 31 PM" src="https://github.com/user-attachments/assets/67350453-437b-4bd7-9fb9-8aa8cc9b5d54">

Instead of predicting UPDRS scores, we decided to categorise each UPDRS score into high and low and use elastic net logistic regression using each of the selected features for the UPDRS scores and looked at accuracy of performance in the training dataset. When we look at accuracy based on using categories rather than scores, the accuracy is better than a random 50%. For UPDRS2, UPDRS3 and UPDRS4 scores, the accuracy is above 70%. While for UPDRS1 it is 69%. Predicting categories rather than scores is simpler and our features for each score category do better.

<img width="250" alt="Screen Shot 2024-08-12 at 7 21 18 PM" src="https://github.com/user-attachments/assets/ea88f7fb-c7a2-45a6-95fe-fa90312debbd">


We proceeded to use elastic net logistic regression on the test dataset and got reasonable Accuracy and F1 scores for predicting high vs low categories for the UPDRS scores.

<img width="348" alt="Screen Shot 2024-08-12 at 7 29 21 PM" src="https://github.com/user-attachments/assets/e97073cf-be36-42d2-abfc-5cfc80656e9c">




