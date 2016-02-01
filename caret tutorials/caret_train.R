library(caret)
library(mlbench)
data(Sonar)

#whenever creating a random sample
set.seed(999)
trainSamples <- createDataPartition(Sonar$Class,p=0.5,list=FALSE)

SonarTrain <- Sonar[trainSamples,]
SonarTest <- Sonar[-trainSamples,]

#use trainControl to sample the training data, 
#change evaluation function summaryFunction: RMSE, ACCU, selectionFunction: best, oneSE, tolerance
fitControl <- trainControl(method="repeatedcv",number = 10,repeats=10,classProbs = TRUE)

#use general boosted tree model to fit
set.seed(825)
#verbose is for the gbm parameter
#train will automatically create a training parameter grid of 3**p (p predictors) size
#final model will give parameters with best performance on cv
#preProcess will be applied to test set when the training model is used
gbmFit1 <- 
  train(Class~.,data=SonarTrain,method='gbm',preProcess=c("center","scale"),trControl=fitControl,verbose=FALSE)



#expand the default parameter tuning to more values using expand.gird
gbmGrid <- expand.grid(interaction.depth=c(1,5,9),n.trees=(1:30)*50,shrinkage=0.1,n.minobsinnode=10)
gbmFit2 <- train(Class~.,data=SonarTrain,method='gbm',tuneGrid=gbmGrid,trControl=fitControl,verbose=FALSE)

#ggplot(gbmFit2)


predictions <- predict(gbmFit2,newdata=SonarTest)

#set the same seed to make sure that same training resamples are used across all training algorithms
set.seed(825)
svmFit1 <- train (Class~.,data=SonarTrain,method="svmRadial",trControl=fitControl,preProcess=c("center","scale"),tuneLength=8)

#comparing the performance of models
resamps <- resamples(list(GBM=gbmFit2,SVM=svmFit1))
bwplot(resamps)

#computing difference between models
diffValues <- diff(resamps)
dotplot(diffValues)

#evaluation of test set
postResample(predictions,SonarTest$Class)






