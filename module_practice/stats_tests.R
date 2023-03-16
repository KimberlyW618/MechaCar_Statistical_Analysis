# The qualitative test for normality is a visual assessment of the distribution of data,
#which looks for the characteristic bell curve shape across the distribution.

ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot

#sampling
population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(used_car_data,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#create a sample dataset using dplyr's sample_n() function
sample_table <- used_car_data %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#t-test 
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(used_car_data$Miles_Driven))) #compare sample versus population means

# 2 sample t-test
sample_table <- used_car_data %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- used_car_data %>% sample_n(50) #generate another 50 randomly sampled data points
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples

# from 2 data sets 
mpg_data <- read.csv('mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008

t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples

#clean data 
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor

#ANOVA test 
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
#add summary to get p-value also
summary(aov(hp ~ cyl,data=mtcars_filt))
# this shows that the p-value is more then 0.05% so the answer is no to the Q >  "Is there any statistical difference in the horsepower of a vehicle based on its engine type?" 

head(mtcars)

#checking for correlation > we'll test whether or not horsepower (hp) is correlated with quarter-mile race time (qsec).
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter 
cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient
#this shows a p-value of -0.71 which shows a strong negative correlation.

#another ex of ^ testing whether or not vehicle miles driven and selling price are correlated
used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F) #read in dataset
head(used_cars)
plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import dataset into ggplot2
plt + geom_point() #create a scatter plot
cor(used_cars$Miles_Driven,used_cars$Selling_Price) #calculate correlation coefficient
#Our calculated r-value is 0.02, which means that there is a negligible correlation between miles driven and selling price in this dataset.

#correlation matrix
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")]) #convert data frame into numeric matrix
cor(used_matrix)
# shows strong correlation between selling price versus present price

# linear regression
lm(qsec ~ hp,mtcars) #create linear model
summary(lm(qsec~hp,mtcars)) #summarize linear model

model <- lm(qsec ~ hp,mtcars) #create linear model
yvals <- model$coefficients['hp']*mtcars$hp +
model$coefficients['(Intercept)'] #determine y-axis values from linear model
#we have calculated our line plot data points, we can plot the linear model over our scatter plot:
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plot scatter and linear model
#Although the relationship between both variables is statistically significant, this linear model is not ideal.
#need to use a more robust mode dataset

#multiple linear regression statement
lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model

summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars)) #generate summary statistics

##################
# is a statistical difference in the distributions of vehicle class across 1999 and 2008 from our mpg dataset,
# chisq.test
table(mpg$class,mpg$year) #generate contingency table

tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distributions
