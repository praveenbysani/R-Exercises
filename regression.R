library("MASS")
library("ISLR")

attach(Boston)
lm.multifit = lm(medv ~ lstat+age)
summary(lm.multifit)
par(mfrow=c(2,2))
plot(lm.multifit)

#to use all predictiors
#lm(medv~.)

#to update the model
#lm.update=update(lm.multifit,~.-age)

#interaction term between lstat and age predictors
#lm.fit=lm(medv ~ lstat*age)
#lm.fit=lm(medv ~ lstat:age)

#non linear transformation of predictors
#lm.fit2=lm (medv~lstat+I(lstat^2))
#lm.polyfit = lm (mev ~ poly(lstat,5))

#analysis of models
#anova(lm.fit,lm.fit2)