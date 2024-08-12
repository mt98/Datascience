
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

<img width="542" alt="Screen Shot 2024-08-11 at 8 10 10 PM" src="https://github.com/user-attachments/assets/521ce2e6-dcf9-4ea9-8d9e-ebf19d2edf90">

<img width="745" alt="Screen Shot 2024-08-11 at 8 10 24 PM" src="https://github.com/user-attachments/assets/3d338c82-d15d-4b83-b713-9f6d1d871e0b">
# 4. Pre-processing
We 


