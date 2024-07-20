# Load necessary libraries
#install.packages("DCA") #Install the neccessary packages
library(tidyverse)
library(rms)
library(survival)
library(survminer)
library(pROC)
#library(DCA)

# Set working directory (update the path as needed)
#setwd("C:\\Users\\n\\Downloads\\Pancreatic_cancer_with_distant metastasis.csv")

# Load the dataset
data <- read.csv("C:\\Users\\n\\Downloads\\Pancreatic_cancer_with_distant metastasis.csv")
data

# Data Preprocessing
data$stage <- as.factor(data$stage)
data$sex <- as.factor(data$sex)

data$plasma_CA19_9[is.na(data$plasma_CA19_9)] <- mean(data$plasma_CA19_9, na.rm = TRUE)
data$creatinine[is.na(data$creatinine)] <- mean(data$creatinine, na.rm = TRUE)
data$LYVE1[is.na(data$LYVE1)] <- mean(data$LYVE1, na.rm = TRUE)
data$REG1B[is.na(data$REG1B)] <- mean(data$REG1B, na.rm = TRUE)
data$TFF1[is.na(data$TFF1)] <- mean(data$TFF1, na.rm = TRUE)
data$REG1A[is.na(data$REG1A)] <- mean(data$REG1A, na.rm = TRUE)

# Check for any remaining missing values
sum(is.na(data))


# Data Visualization

# 1. Histogram of Age
ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  labs(title = "Distribution of Age", x = "Age", y = "Frequency")

# 2. Boxplot of Plasma CA19-9 by Stage
ggplot(data, aes(x = stage, y = plasma_CA19_9)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Plasma CA19-9 Levels by Stage", x = "Stage", y = "Plasma CA19-9")

# 3. Scatter plot of Age vs Plasma CA19-9
ggplot(data, aes(x = age, y = plasma_CA19_9)) +
  geom_point(color = "purple") +
  labs(title = "Age vs Plasma CA19-9", x = "Age", y = "Plasma CA19-9")

# 4. Bar plot of Sex
ggplot(data, aes(x = sex)) +
  geom_bar(fill = "green") +
  labs(title = "Distribution of Sex", x = "Sex", y = "Count")

# 5. Boxplot of Creatinine by Stage
ggplot(data, aes(x = stage, y = creatinine)) +
  geom_boxplot(fill = "pink") +
  labs(title = "Creatinine Levels by Stage", x = "Stage", y = "Creatinine")

# 6. Scatter plot of Age vs Creatinine
ggplot(data, aes(x = age, y = creatinine)) +
  geom_point(color = "red") +
  labs(title = "Age vs Creatinine", x = "Age", y = "Creatinine")

# 7. Boxplot of LYVE1 by Stage
ggplot(data, aes(x = stage, y = LYVE1)) +
  geom_boxplot(fill = "cyan") +
  labs(title = "LYVE1 Levels by Stage", x = "Stage", y = "LYVE1")

# 8. Scatter plot of Creatinine vs. Age
ggplot(data, aes(x = age, y = creatinine)) +
  geom_point(color = "orange") +
  theme_minimal() +
  labs(title = "Creatinine vs. Age", x = "Age", y = "Creatinine")

# Save the visualizations as images
ggsave("C:\\Users\\n\\Downloads\\histogram_age.jpg", width = 8, height = 6)
ggsave("C:\\Users\\n\\Downloads\\boxplot_plasma_CA19_9.jpg", width = 8, height = 6)
ggsave("C:\\Users\\n\\Downloads\\scatter_age_plasma_CA19_9.jpg", width = 8, height = 6)
ggsave("C:\\Users\\n\\Downloads\\barplot_sex.jpg", width = 8, height = 6)
ggsave("C:\\Users\\n\\Downloads\\boxplot_creatinine.jpg", width = 8, height = 6)
ggsave("C:\\Users\\n\\Downloads\\scatter_age_creatinine.jpg", width = 8, height = 6)
ggsave("C:\\Users\\n\\Downloads\\boxplot_LYVE1.jpg", width = 8, height = 6)
ggsave("C:\\Users\\n\\Downloads\\creatinine_vs_age.jpg", width = 8, height = 6)



# 1. Multivariable Logistic Regression Analysis
logistic_model <- glm(stage ~ age + sex + plasma_CA19_9 + creatinine + LYVE1 + REG1B + TFF1 + REG1A,
                      data = data,
                      family = binomial)
summary(logistic_model)

# 2. Diagnostic Nomogram Development
dd <- datadist(data)
options(datadist = "dd")

nomogram_model <- lrm(stage ~ plasma_CA19_9 + age, data = data)
nomogram <- nomogram(nomogram_model, fun = list("Probability" = function(x) 1 / (1 + exp(-x))))

# Save the nomogram as an image with a larger size
jpeg("C:\\Users\\n\\Downloads\\nomogram.jpg", width = 800, height = 600)
plot(nomogram)
dev.off()

# Dynamic Web-based Application (using Shiny)
library(shiny)

# Define UI for the application
ui <- fluidPage(
  titlePanel("Pancreatic Cancer Diagnostic Nomogram"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Age:", value = 50, min = 0),
      numericInput("plasma_CA19_9", "Plasma CA19-9:", value = 10, min = 0)
    ),
    
    mainPanel(
      textOutput("prediction")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$prediction <- renderText({
    newdata <- data.frame(age = input$age, plasma_CA19_9 = input$plasma_CA19_9)
    pred <- plogis(predict(nomogram_model, newdata = newdata))
    paste("Probability of distant metastasis:", round(pred * 100, 2), "%")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


# 3.Cox Regression Analysis

# Load necessary libraries
library(survival)
library(survminer)
library(dplyr)
library(ggplot2)

# Load your dataset
data <- read.csv('C:\\Users\\n\\Downloads\\Pancreatic_cancer_with_distant metastasis.csv')

# For demonstration purposes, let's create synthetic OS_time and OS_event
set.seed(123)  # For reproducibility
data$OS_time <- sample(30:3650, nrow(data), replace = TRUE)  # Survival times in days
data$OS_event <- sample(0:1, nrow(data), replace = TRUE)  # Event indicator (0=censored, 1=event)

# Fit Cox proportional hazards model
cox_model <- coxph(Surv(OS_time, OS_event) ~ age + sex + stage + creatinine + LYVE1 + REG1B + TFF1 + REG1A, data = data)

# Summary of the model
summary(cox_model)

#1.3 Diagnostic Plots

# Schoenfeld residuals test for proportional hazards assumption
cox.zph(cox_model)

# Plot Schoenfeld residuals
ggcoxzph(cox.zph(cox_model))


# Recode 'stage' to binary stages if needed
data$stage_binary <- factor(data$stage, levels = c("I", "II", "III", "IV"))  # Adjust based on actual stage levels
data$stage_binary <- ifelse(data$stage_binary %in% c("I", "II"), "Early", "Late")
data$stage_binary <- factor(data$stage_binary, levels = c("Early", "Late"))

# Ensure there are observations in both levels
print(table(data$stage_binary))

# 4. Predict probabilities from the nomogram model
predicted_prob <- predict(nomogram_model, newdata = data, type = "fitted")
print(predicted_prob)
# Ensure 'predicted_prob' is a numeric vector
if (is.matrix(predicted_prob)) {
  predicted_prob <- predicted_prob[, 1]
}
predicted_prob <- as.numeric(predicted_prob)

# Check dimensions
if (length(predicted_prob) != nrow(data)) {
  stop("Length of predicted_prob does not match number of rows in data.")
}

# 5. Evaluation of nomogram efficiency ROC Curve C-Index DCA Curve
# Perform ROC Analysis
library(pROC)
roc_curve <- roc(data$stage_binary, predicted_prob)

# Save ROC curve plot
jpeg("C:\\Users\\n\\Downloads\\roc_curve.jpg", width = 800, height = 600)
plot(roc_curve, main = "ROC Curve for Nomogram Model")
dev.off()
auc(roc_curve)

c_index <- concordance.index(predict(cox_multivariate), data$stage)
print(c_index)

dca_data <- dca(cox_multivariate)
jpeg("C:\\Users\\n\\Downloads\\dca_curve.jpg", width = 800, height = 600)
plot(dca_data)
dev.off()

# Save results to CSV
write.csv(data.frame(summary(logistic_model)), "C:\\Users\\n\\Downloads\\logistic_model_summary.csv")
write.csv(data.frame(summary(cox_multivariate)), "C:\\Users\\n\\Downloads\\cox_multivariate_summary.csv")
