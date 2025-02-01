# Classification of Pneumonia in Chest X-ray images
## 1. Data
 5856 Chest X-ray images were available for retrospective cohort of child patients. The data was available from [Kaggle](https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia?resource=download/).It was divided into training, test and validation images in separate folders.
 ## 2. Exploratory data analyses
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

## 3. Pre-processing and model building
We conducted pre-processing and built a model to predict the image classification using neural networks. [Github](https://github.com/mt98/Datascience/blob/909652b2e188b0f202ac1fe77ec48488f532d253/Capstone_three/Pre-processing_modeling.ipynb)
Given that we had an imbalanced training dataset we carried out data augmentation and balanced weights for the training data set. We tried two  neural network  models, Resnet50 model with frozen weights trained on Imagenet and a traditional CNN model. We 
looked at performance of both models on training and validation accuracy and loss function. 
![training_validation_loss](https://github.com/user-attachments/assets/6625a363-0912-48b8-871a-d3ac6f6d61b8)
![training_validation_loss_CNN](https://github.com/user-attachments/assets/a642719c-7fe1-4e72-b5bf-78d16429a274)

It can be seen that the Resnet50 model has a much higher validation accuracy and hence we decide to use it to evaluate our test data set. When we use the resnet50 model, the test accuracy is 93.8%.

## 4. Conclusions
We were successfully able to classify Chest X-ray images in a test data set acheiving a high accuracy using the Resnet50 model.

