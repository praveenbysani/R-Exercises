## ensembling two or more caret train models
#caretList - creates list of caret train models with sample resampling indexes
#caretEnsemble - combines a linear combination of models
#caretStack - creates a meta model from input models
library(caret)
library(caretEnsemble)
library(mlbench)
library(caTools)

trainSamples <- createDataPartition(Sonar$Class,p=0.5,list=FALSE)

SonarTrain <- Sonar[trainSamples,]
SonarTest <- Sonar[-trainSamples,]
fitControl <- trainControl(method='boot',number=25,classProbs = TRUE,
                           savePredictions = TRUE,summaryFunction = twoClassSummary)

#create a svm and glm model with same train samples, contains a list of models
caretModels <- caretList(Class~.,SonarTrain,trControl = fitControl,methodList = c('glm','svmRadial'))
#to look at the summary of models
summary(resamples(caretModels))
#predict using individual models in the caret list of models
caretModelProbs <- lapply(caretModels,predict,newdata=SonarTest,type='prob')
#extract the probs of class M in each list
caretModelProbs <- lapply(caretModelProbs,function(x) x$M)
caretModelProbs <- data.frame(caretModelProbs)
colAuc(caretModelProbs,SonarTest$Class)

#correlation between models
modelCor(resamples(caretModels))
##ensemble is ideal when correlation is less and the accuracy is similar between
#two models

caretEns <- caretEnsemble(caretModels)
summary(caretEns)
predict(caretEns,newdata=SonarTest)
##variable importance
varImp(caretEns)

#use a different train control for stacking
stackControl <- trainControl(method = 'boot',number=10,classProbs = TRUE,summaryFunction = twoClassSummary,savePredictions = TRUE)
# a gbm tree built upon the predictions of svm and glm
carStackEns <- caretStack(caretModels,method='gbm',trControl=stackControl,
                          verbose=FALSE,metric='ROC')

predict(carStackEns,newdata=SonarTest,type="prob")
                          

