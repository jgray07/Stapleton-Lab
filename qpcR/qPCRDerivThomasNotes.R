#Trials

##Thomas notes:
#dffit <- pcrfit(test, 1,2, b) gave an error, changed to:
#dffit <- pcrfit(test, 1,2, b6) based on context
#Also it's good to comment out the install.packages() as it only has to be done once
#Additionally, in each file you only need to library() a package once




#Based on the QpcR package, there are multiple tools and functions
#I followed the steps in the documentation of qpcR by Andrej-Nikolai Spiess to get know truth with the derivative functions 

#I picked example of a curve I knew was true, a linear curve, steps are down below
#Linear Curve
#install.packages("qpcR")
#install.packages("chipPCR")
library(qpcR)
library(chipPCR)

df <- data.frame(x=seq(1:10),y=seq(1:10))
plot(df) #A data frame from 1-10, and plotted


#Note that this uses the b4 regression model
#Others can be found at ?b4
dffit <- pcrfit(df, 1,2, b4)
plot(dffit) 

df1 <- b4$d1(dffit$DATA[,1], coef(dffit))
lines(df1, col=2) 
plot(df1) #first derivative function


df2 <- b4$d2(dffit$DATA[,1], coef(dffit))
lines(df2, col=2) 
plot(df2) #second derivative function

#######
View(df1)
View(df2)
#By viewing results we see and get reaffirmed, knowing the derivatives
#der1 = 1, der2 = 0

test <- AmpSim(cyc = 1:35, b.eff = 25, bl = 0, ampl = 50, Cq = 25, noise = 5
               , nnl =  0.025, nnl.method = "constant")
plot(test)

dffit <- pcrfit(test, 1,2, b6)
plot(dffit) 

df1 <- b6$d1(dffit$DATA[,1], coef(dffit))
lines(df1, col=2) 
plot(df1) #first derivative function

df2 <- b6$d2(dffit$DATA[,1], coef(dffit))
lines(df2, col=2) 
plot(df2)


#Trials2

#Thomas Notes:
#You say the max of d1 should equal the Cq, however in your example below 
#Cq = 20 and max(d1) = 15.63, given that noise = FALSE, shouldn't max(d1) == Cq?

#Also in the lower example Cq = 25 and the maximum magnitude of d3 = 12.57
#By your previous statement shouldn't it be close to 25?


#install.packages("qpcR")
#install.packages("chipPCR")
library(qpcR)
library(chipPCR)

fit <- AmpSim(cyc = 1:35, b.eff = -25, bl = 0, ampl = 50, Cq = 20, noise = FALSE
              , nnl =  0.025, nnl.method = "constant")
plot(fit) #AmpSim creates simulated data and is plotted

fit2 <- pcrfit(fit, 1, 2, b4) #fits curves and plotted
plot(fit2)

d1 <- b4$d1(fit2$DATA[, 1], coef(fit2))
plot(fit2)
lines(d1, col = 2)
d2 <- b4$d2(fit2$DATA[, 1], coef(fit2))
plot(fit2)
lines(d2, col = 2)
#First and second derivative and plotted against first curve. Cq should be maximum for the first derivative. 
#To test this you set your Cq to any value within reason and test using the derivative function in qcpR package
View(d1)
View(d2)


#### Below are the same but with some parameters changed and seeing how noise effects the curve

fit3 <- AmpSim(cyc = 1:35, b.eff = 25, bl = 0, ampl = 50, Cq = 25, noise = 5
              , nnl =  0.025, nnl.method = "constant")
plot(fit3)

fit4 <- pcrfit(fit3, 1, 2, b4)
plot(fit4)
# Instead of a sigmoidal growth curve this is decay, because b.eff parameter
d3 <- b4$d1(fit4$DATA[, 1], coef(fit4))
plot(fit4)
lines(d3, col = 2)
d4 <- b4$d2(fit4$DATA[, 1], coef(fit4))
plot(fit4)
lines(d4, col = 2)
# Noise effects the fit of the curve. Since it effects the curve the derivative will be influenced as well 
View(d3)
View(d4)
# Changing the parameters shifts the derivative and translates it. With a shifted Cq value it shifts the max point, in this case 25
# Cq value can be used as your known truth as seen above