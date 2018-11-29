#for facility location

install.packages("SpatialEpi")
library(SpatialEpi)
library(openxlsx)

## Convert coordinates
coord <- data.frame(coor$long,coor$lat)
  # Montreal, QC:  Latitude: 45deg 28' 0" N (deg min sec), Longitude: 73deg 45' 0" W
  
  # Vancouver, BC:  Latitude: 45deg 39' 38" N (deg min sec), Longitude: 122deg 36' 15" W

x=latlong2grid(coord)
write.xlsx(latlong2grid(coord), 'ranaxy.xlsx')

## Robustness of the geometric median of n=3 points in dimension d=2.
install.packages("Gmedian")
library(Gmedian)

plot(x,xlab="x",ylab="y")
med.est <- Weiszfeld(x)
points(med.est$median,pch=19)

### weighted units
poids = c(ranaxy$population_increase_rate_per_decades)
plot(x,xlab="x",ylab="y")
med.est <- Weiszfeld(x,weights=poids)
plot(x,xlab="x",ylab="y")
points(med.est$median,pch=19)
