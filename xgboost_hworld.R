library(xgboost)

data("agaricus.train")
data("agaricus.test")

#sparse matrices, dgcMatrix
train_xg <- agaricus.train
test_xg <- agaricus.test

dim(train_xg$data)

bstSparse <- xgboost(data = train_xg$data, label = train_xg$label, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")
#combine train and label into xgb matrix
dtrain <- xgb.DMatrix(data = train_xg$data, label = train_xg$label)
bstDMatrix <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")

pred <- predict(bstSparse, test_xg$data)

#advanced learning
dtest <- xgb.DMatrix(data=test_xg$data, label = test_xg$label)
watchlist <- list(train=dtrain, test=dtest)
bst <- xgb.train(data=dtrain, max.depth=2, eta=1, nthread = 2, nround=2, 
                 watchlist=watchlist, objective = "binary:logistic")
#watch more than one metric
bst <- xgb.train(data=dtrain, max.depth=2, eta=1, nthread = 2, nround=2, watchlist=watchlist, 
                 eval.metric = "error", eval.metric = "logloss", objective = "binary:logistic")



