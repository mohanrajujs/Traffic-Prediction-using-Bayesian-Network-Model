library(bnspatial)
data(ConwyData)
list2env(ConwyData, environment())

network <- LandUseChange
spatialData <- c(ConwyLU, ConwySlope, ConwyStatus)
lookup <- LUclasses
target <- 'FinalLULC'

## Run a spatial query on the Bayesian network 
## A summary will be printed on screen to check whether spatial data correspond 
## to network nodes as intended.
bn <- bnspatial(network, target, spatialData, lookup)
bn

## Plot output maps
library(raster)
par(mfrow=c(1,2))
plot(bn$Class, main='Most likely class')
plot(bn$Entropy, main='Uncertainty (Shannon index)')