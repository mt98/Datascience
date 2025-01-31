# Classification of Pneumonia in Chest X-ray images
## 1. Data
 5856 Chest X-ray images were available for retrospective cohort of child patients. The data was available from [Kaggle](https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia?resource=download/).It was divided into training, test and validation images in separate folders.
 ## 2.Exploratory data analyses
 We conducted exploratory data analyses on the available images in the training, validation and test data sets [Github](https://github.com/mt98/Datascience/blob/97a452dddd20e697dbca1a8acca705ea3cfd6596/Capstone_three/Data_wrangling_EDA.ipynb).
 We saw that the training data set had 5216 images, which was imbalanced with 3 times more pneumonia images compared to normal images.
 
 ![Balancingplot_training](https://github.com/user-attachments/assets/e2d3a9d3-860c-4e08-918f-f83d456b857c)

 We also looked at the images in the validation and testing data sets, which were fewer than in the training data set but balanced.

 |         |Pneumonia | Normal |
|:---------|----:|:-----------:|
| Training    |  390 | 234   |
| Validation  |  8 |8|

A few images for Chest X-ray images were visualised after resizing.

![training_xray](https://github.com/user-attachments/assets/68e6851a-e759-4948-a120-d474c06ed158)

