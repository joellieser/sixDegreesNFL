require(reshape2)
require(data.table)
require(stringr)
require(igraph)

set.seed(26)

load('~/Desktop/sixDegrees/k.RData')
load('~/Desktop/sixDegrees/g2.RData')
load('~/Desktop/sixDegrees/distMatrix2.RData')

allPaths <- get.all.shortest.paths(g, from=V(g), to=V(g), mode = c("all", weights = NULL))

print("allPaths complete")
format(Sys.time(), "%H:%M:%S")

save(allPaths,file='~/Desktop/sixDegrees/allPaths.RData')


