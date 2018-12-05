install.packages("SpatialEpi")

library(SpatialEpi)

library(openxlsx)

install.packages("Gmedian")

library(Gmedian)
X <- data.frame(sheet50$X_Utm,sheet50$Y_Utm)

plot(X,xlab="x",ylab="y")


### weighted units

poids <- c(sheet50$Wi)


med.est <- Weiszfeld(X,weights=poids)

plot(X,xlab="x",ylab="y")

points(med.est$median,pch=19)

med.est$median








