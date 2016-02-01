library(C50)
library(caret)
data(churn)

##data splits
#stratified sampling
createDataPartition()
#y - labels, p= portion of train data, list=FALSE (easy to subset)
#bootstrap samples
createResample()

## pre processing of data
#centering,scaling,imputation,PCA,box-cox transformations etc
numerics <- c('account_length','total_day_calls','total_night_calls')
#determine means
procValues <- preProcess(churnTrain[,numerics],method=c('center','knnImpute'))
#use processed object to do the transformations on target data
trainScaled <- predict(procValues,churnTrain[,numerics])
testScaled <- predict(procValues,churnTest[,numerics])

#remove the variables that has near to zero variance (not useful)
zCols <- nearZeroVar(churnTrain)
churnTrain <- churnTrain[,-zCols]


#remove highly correlated attributes
##findCorrelation 

#create dummy variables for factor variables
dummies <- dummyVars(churn~.,data=churnTrain)
churntTrainVars <- predict(dummies,newdata=churnTrain)






