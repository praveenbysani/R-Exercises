library(caret)

set.seed(800)
trainSim <- twoClassSim(1000)
evalSim <- twoClassSim(1000)
tetSim <- twoClassSim(1000)

ctrl <- trainControl(method="cv",classProbs = TRUE, summaryFunction = twoClassSummary)

set.seed(800)
fdaModel <- train(Class~.,data=trainSim,trControl=ctrl,metric="ROC",method="fda",tuneLength=20)
ldaModel <- train(Class~.,data=trainSim,trControl=ctrl,metric="ROC",method="lda",tuneLength=20)
svModel <-  train(Class~.,data=trainSim,trControl=ctrl,metric="ROC",method="svmRadial",tuneLength=20)

#performance summary of training
getTrainPerf(fdaModel)

#creating a lift chart across different learning schemes
evalResults <- data.frame(Class= evalSim$Class)
evalResults$FDA <- predict(fdaModel,evalSim,type="prob")[,"Class1"]
evalResults$LDA <- predict(ldaModel,evalSim,type="prob")[,"Class1"]
evalResults$SVM <- predict(svModel,evalSim,type="prob")[,"Class1"]

liftData <- lift(Class ~ FDA+LDA+SVM, data=evalResults)
