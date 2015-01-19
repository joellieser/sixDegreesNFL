require(reshape2)
require(data.table)
require(stringr)
require(igraph)

set.seed(26)

load('~/Desktop/sixDegrees/k.RData')
load('~/Desktop/sixDegrees/g2.RData')
load('~/Desktop/sixDegrees/distMatrix2.RData')

#h <- get.shortest.paths(g,which(rownames(distMatrix)=='Brown, Ted'),which(colnames(distMatrix)=='Ditka, Mike'))$vpath

showRelationships <- function(fromPlayer,toPlayer){
    h <- get.shortest.paths(g,which(rownames(distMatrix)==fromPlayer),which(colnames(distMatrix)==toPlayer))$vpath
    tempList <- h[[1]]
    numDegrees <- length(rownames(distMatrix)[tempList])
    tempMatrix <- distMatrix[tempList,tempList]
    tempMatrix[tempMatrix > 1] <- 0
    rownames(tempMatrix) <- k[tempList]
    colnames(tempMatrix) <- k[tempList]
    g2 <- graph.adjacency(tempMatrix, weighted=T, mode = 'undirected')
    g2 <- simplify(g2)
    V(g2)$label <- V(g2)$name
    V(g2)$degree <- degree(g2)
    layout1 <- layout.fruchterman.reingold(g2)
    return(plot(g2, layout=layout1))
}

x <- showRelationships('Brown, Ted','Ditka, Mike')

x <- showRelationships('Staubach, Roger','Bridgewater, Teddy')



x <- showRelationships('','')