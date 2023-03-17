############     MechaCarChallenge.RScript     ###########

require(pacman)
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, ggvis, 
               httr, lubridate, plotly, rio, rmarkdown, shiny, 
               stringr, tidyr)
library(datasets)

############     Part 1: Linear Regression to Predict MPG     ###########

#import MschaCar_mpg csv into dataframe
mecha_data = read.csv("/Users/kimberlywoods/R_Analysis/MC_analysis/MechaCar_mpg.csv")
head(mecha_data)

# linear regression
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + 
     ground_clearance + AWD, mecha_data)

#summary to ge the p-value and the r-squared value
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + 
             ground_clearance + AWD, mecha_data))

# p-value = 5.35e-11
# Multiple R-squared = 0.7149
# Adjusted R-squared = 0.6825 

##### See the ReadMe for written analysis

############     Part 2: Create Visualizations for the Trip Analysis     ###########

#import Suspension_Coil csv into dataframe
coil_data = read.csv("/Users/kimberlywoods/R_Analysis/MC_analysis/Suspension_Coil.csv")
head(coil_data)

# Using the summarize() function, get the mean, median, variance, and standard 
##  deviation of the suspension coil’s PSI column.
total_summary <- coil_data %>% summarize(Mean = mean(PSI), Median = median(PSI), 
                                         Variance = var(PSI), SD = sd(PSI))
total_summary

# Using the group_by() and the summarize() functions to group each manufacturing 
##  lot by the mean, median, variance, and standard deviation of the suspension coil’s PSI column
lot_summary <- coil_data %>% group_by(Manufacturing_Lot) %>% summarize(Mean = mean(PSI), 
                                                                       Median = median(PSI), 
                                                                       Variance = var(PSI), 
                                                                       SD = sd(PSI), 
                                                                       .groups = 'keep')
lot_summary


############     Part 3: T-Tests on Suspension Coils     ###########

# Use the t.test() function to determine the PSI across all manufacturing lots
## compared to population mean of 1,500 pounds per square inch
t.test(coil_data$PSI, mu=1500) 

# Create subset of data for each lot 
lot_1 <- subset(coil_data, Manufacturing_Lot == "Lot1")
lot_2 <- subset(coil_data, Manufacturing_Lot == "Lot2")
lot_3 <- subset(coil_data, Manufacturing_Lot == "Lot3")

# Do a t-test for each lot comparing to population mean 
t.test(lot_1$PSI, mu=1500) 
t.test(lot_2$PSI, mu=1500) 
t.test(lot_3$PSI, mu=1500) 

