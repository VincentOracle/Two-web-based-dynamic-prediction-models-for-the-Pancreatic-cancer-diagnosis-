# Introduction
## Overview of Pancreatic Cancer with Distant Metastasis
Pancreatic cancer is one of the most lethal malignancies, characterized by its aggressive nature and poor prognosis. A significant contributor to this dismal outlook is the high incidence of distant metastasis at the time of diagnosis. Distant metastasis occurs when cancer cells spread from the primary tumor in the pancreas to other parts of the body, such as the liver, lungs, or peritoneum. This advanced stage of the disease is often associated with severe symptoms and limited treatment options, resulting in a median survival time of less than a year for most patients. Understanding the factors that contribute to distant metastasis is crucial for early diagnosis and improving patient outcomes.
## Objectives of the Study
This study aims to develop predictive and prognostic tools for pancreatic cancer with distant metastasis. The primary objectives are to:
i.Identify the variables associated with the development of distant metastases using multivariable logistic regression analysis.
ii.Construct a diagnostic nomogram based on significant risk factors and create a dynamic web-based application for predicting the probability of distant metastasis.
iii.Analyze prognostic factors in patients with distant metastasis and develop a prognostic nomogram for overall survival.
iv.Evaluate the efficiency of the nomograms using ROC Curve, C-Index, and Decision Curve Analysis (DCA).
## Description of the Dataset and Variables Used (Data and Methods)
The dataset used in this study, "Pancreatic_cancer_with_distant_metastasis.csv," was obtained from the SEER database and contains data on 591 patients diagnosed with pancreatic cancer. The dataset includes 14 variables: patient demographics (age, sex, race), clinical features (tumor size, grade, stage), treatment modalities (surgery, radiation, chemotherapy), and survival outcomes. Key variables analyzed in this study include age, sex, tumor size, grade, stage, and treatment types. 
Data preprocessing steps included handling missing values and applying necessary transformations to prepare the data for analysis. This comprehensive dataset enables a thorough examination of factors influencing distant metastasis and overall survival in pancreatic cancer patients(Liu et al, 2023).

# Data Preprocessing
## Handling Missing Values
Handling missing values is a critical step in data preprocessing to ensure the accuracy and reliability of the analysis. In the dataset "Pancreatic_cancer_with_distant_metastasis.csv," missing values were present in several variables, such as tumor size, grade, and treatment modalities. To address this issue, a systematic approach was employed.
![image](https://github.com/user-attachments/assets/6548e40a-cd38-408d-af12-17953e4a8f81)

For variables with a low percentage of missing values (less than 5%), missing data were imputed using the mean or median for continuous variables and the mode for categorical variables. For variables with a higher percentage of missing data, advanced imputation techniques like multiple imputation were used to preserve the dataset's integrity and avoid potential biases (Olukoya, 2024). In cases where the proportion of missing values was excessively high, those variables were either excluded from the analysis or combined with similar variables to retain as much information as possible without compromising the quality of the dataset.

## Data Transformations
Data transformations are necessary to prepare the dataset for statistical analysis and to enhance the interpretability of the results. Several transformations were applied to the dataset:
Normalization and Scaling- Continuous variables, such as age and tumor size, were normalized to a common scale using techniques like z-score normalization. This step ensured that all variables contributed equally to the analysis and prevented any single variable from disproportionately influencing the results.
Categorical Encoding- Categorical variables, such as sex, race, and treatment types, were encoded into numerical formats using one-hot encoding or label encoding, depending on the variable's nature and the requirements of the statistical models.
Creation of New Variables- New variables were created to capture interactions or nonlinear effects. For instance, age was squared to account for potential nonlinear relationships between age and the likelihood of distant metastasis. Similarly, interaction terms between tumor size and grade were created to explore their combined effect on the outcome.
Outlier Detection and Treatment- Outliers were detected using statistical methods such as the interquartile range (IQR) and z-scores. Identified outliers were either transformed to reduce their impact or excluded if they were deemed to be erroneous entries.
These preprocessing steps ensured that the dataset was clean, well-structured, and ready for subsequent analysis, enhancing the reliability and validity of the study's findings.


Data Visualization
Data visualization plays a crucial role in understanding the distribution and relationships within the dataset. Various plots were employed to gain insights into the data.
Histograms
Histograms were used to visualize the distribution of continuous variables such as age, tumor size, and overall survival time. 
![image](https://github.com/user-attachments/assets/26a48b3e-aa31-475b-879a-80bea6fee50f)

These plots revealed that age distribution among patients was relatively normal, with a slight skew towards older age groups. Tumor size showed a right-skewed distribution, indicating a larger number of smaller tumors. 	In sum, survival time also displayed a right-skewed distribution, suggesting that while most patients had shorter survival times, a few survived significantly longer (Liu et al, 2024).
Boxplots
Boxplots provided a summary of the distribution and highlighted potential outliers for variables like tumor size and age across different groups, such as sex and treatment types. 
![image](https://github.com/user-attachments/assets/cc267076-766d-44f9-bd1f-62c32e270d20)

The boxplots indicated that males generally had larger tumors compared to females in the levels by stage. Outliers were identified, particularly in tumor size, pointing towards extreme values that warranted further investigation.


Scatter Plots
Scatter plots were utilized to explore relationships between continuous variables. 

For example, a scatter plot of tumor size versus age showed no significant correlation, suggesting that tumor size is independent of patient age.

 Another scatter plot of overall survival time versus age indicated a slight negative correlation, with older patients tending to have shorter survival times.
Bar Plots
Bar plots were used to compare the frequency of categorical variables, such as the distribution of different treatment types and tumor grades distributed per sex.
![Uploading image.png…]()


These plots highlighted that the majority of patients received chemotherapy, while a smaller proportion underwent surgery or radiation. Tumor grade distribution showed a higher prevalence of moderately and poorly differentiated tumors.
Insights Gained
The visualizations revealed several important patterns:
Age distribution skewed towards older patients.
Tumor size and overall survival time both displayed right-skewed distributions.
Females tended to have larger tumors.
No significant correlation between age and tumor size.
Negative correlation between age and overall survival time.
Majority of patients received chemotherapy, with fewer undergoing surgery or radiation.
These insights provided a deeper understanding of the dataset's characteristics and guided subsequent analyses.




