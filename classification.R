library(ISLR)
#load stock market data
attach(Smarket)

#covariance matrix of quantitative attributes
cor(Smarket[1:8])

#fit a logistic regression model to the data, family binomial represents lr 
glm.fit = glm(Direction~Lag1+Lag2+Lag3+Lag5+Volume,family=binomial)

#coef(glm.fit) provides only coefficients

#predict the training data, output in probabilities
glm.prob = predict(glm.fit,type='response')
#convert probabilities into qualitative variables
glm.pred = rep("Down",1250)
glm.pred[glm.prob>0.5]="Up"

#create a confusion matrix
table(Direction,glm.pred)

#subsetting training and test data
train=(Year<2005)
Smarket.2005 = Smarket[!train,]
Direction.2005 = Direction[!train]

