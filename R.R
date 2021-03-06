# lm formula
form.in<-paste('y ~',paste(names(lm.dat)[-1],collapse='+'))


# get index of particuler value
match("Amir", df$Name) # df$Name ka wo index batao jis me Amir h

# Opposite of %in% .............. D2 = subset(D1, !(V1 %in% c('B','N','T'))).......... 
# You can also make an operator yourself:
'%!in%' <- function(x,y)!('%in%'(x,y))
c(1,3,11)%!in%1:10
[1] FALSE FALSE  TRUE
# https://stackoverflow.com/questions/5831794/opposite-of-in

# Build a model excluding the tax variable
model2 <- lm(medv ~. -tax, data = train.data)


# split data into train and test with regards of distribution of target variable
split = caTools::sample.split(df$target_var, Split.Ratio = 0.75) # test retio os 75 %
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)



# ROC curve
library(ROCR)
Rocr_pred <- prediction(prediction_train, df$target_var)
Rocr_perf <- performance(Rocr_pred, "X axis label", "Y axis label")
plot(Rocr_perf, colorize = TRUE, print.cutoffs.at = seq(0,1,0.1), text.adj = c(-0.2, 1.7))
	

# confusion matrix:
table(train$target_var, test_predictions > THRESHOLD)


# AUC value on testing set
# AUC : height value of AUC value means: the model can differentiate low-risk from high-risk patients (eg: AUC=0.75)
library(ROCR)
Rocr_pred <- ROCR::prediction(test_predictions, df$target_var)
as.numeric(ROCR::performance(Rocr_pred, "auc")@y.values)


# Multiple imputation
library(mice)
simple = df[c("col1", "col2", "col3", "col4")] # col1 and col2 have missing values
set.seed(144)
imputed = complete(mice(simple))
df$col1 = imputed$col1
df$col2 = imputed$col2



sign : negative to -1; posetive to 1; and 0 to 0
sign(-4) ==> -1
sign(9)  ==> 1
sign(0)  ==> 0




# kafi dafa hamary pas value character me hoti h or itni bari hoti h k screen ko scroll right karna partha h. to <strwrap> esy long character ko muliple lines me print karta h
# eg: 
> email
[1] "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla"
>strwrap(email)
[1] "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla"  $
[2] "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla"      $ 


# remove the variable ................. df$vairble_to_remove = NULL
# remove duplicate rows ............... df <- unique(df)

########################################################
# date and time from character vector
> head(df$Date, 1)
[1] "12/31/12 23:15"

df$Date <- strptime(df$Date, format="%m/%d/%y %H:%M")
df$Weekday <- weekdays(df$Date)
df$Hour <- df$Date$hour
########################################################

#find missing values in sequance .......... setdiff(1:7, df$y)
# run R command from terminal (without entering in R console) ........... R -e 'install.packages("caret")' ,,,,,,,,,,,,, OR ........... Rscript <(echo "head(iris,2)")
# To install to the default location: ................. R -e 'install.packages(c("package1", "package2"))' .............. To install to a location that requires root privileges: .............. R -e 'install.packages(c("package1", "package2"), lib="/usr/local/lib/R/site-library")' 
# to make R script executable ;check where is <Rscript> by <which Rscript> ; and add that line as sheband. .............. OR .......... R < scriptName.R --no-save  ......... OR ........ Rscript <(zcat a.r) 


# fit.1 <- glm(employed == "yes" ~ ., data = dat, family = binomial)
# tempfit <- update(fit.1, .~. + factor(young.children == 0) 
#                             + factor(school.children == 0)
#                             + factor(young.children + 
#                               school.children == 0))

# get size of object ............... object.size(My_Data_Frame)
# run R command from linux turminal (as we run python command (eg: python3 -c "import numpy as np; print(help(np))" ) .................. r -e 'print(dim(read.csv("github/Kaggle-compitations/sonar/sonar.csv")))'
