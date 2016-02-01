library(ggplot2)

#components

#data
#geometrical objects (geom): bars, points etc
#statistical transformation: bin,identity
#layers = data, mapping, stat, position, geom

#scales : linear
#co ordinate system: cartesian,

#basic plotting for 2 variables
qplot(displ,hwy,data = mpg)

#add color, shape, size aesthetics

qplot(displ,hwy,color=class,size=cyl,shape=fl,data=mpg)

#facet_grid helps to plot different subsets of data
qplot(displ,hwy,color=class,size=cyl,shape=fl,data=mpg)+facet_grid(drv~.)

#wrap around facet graphs, when the facet is big
qplot(displ,hwy,color=class,size=cyl,shape=fl,data=mpg)+facet_wrap(class~.)
# geom helps to determine plot type
qplot(class,hwy,data=mpg,geom='boxplot')

#reorder helps to sort the first argument according to second argument
qplot(reorder(class,hwy),hwy,data=mpg,geom='boxplot')

# to overlap two types in one graph
qplot(reorder(class,hwy),hwy,data=mpg,geom=c('jitter','boxplot'))

#demonstrate layers
ggplot(mpg,aes(displ,hwy))+
  geom_point(aes(size=cyl),alpha=1/2)+
  geom_smooth()+
  scale_size_area()






