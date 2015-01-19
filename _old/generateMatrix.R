require(reshape2)
require(data.table)
require(stringr)
require(igraph)

set.seed(26)

nflRosters <- fread('~/Desktop/sixDegrees/datanormalizedNFL3.txt',sep="\t", header=FALSE)
#nflRosters <- nflRosters[1:5000,]

print("rosters read")
format(Sys.time(), "%H:%M:%S")

g <- get.adjacency(graph.edgelist(as.matrix(nflRosters), directed=FALSE))

print("adjacency matrix created")
format(Sys.time(), "%H:%M:%S")

g <- graph.adjacency(g, weighted=T, mode = 'undirected')

print("graph created")
format(Sys.time(), "%H:%M:%S")

g <- simplify(g)
print("simplify completed")
format(Sys.time(), "%H:%M:%S")

tempNames <- V(g)$name

k <- substring(tempNames,str_locate(tempNames,'\\|')+1,str_length(tempNames))
k <- k[1:(length(k)/2)]
k[is.na(k)] <- tempNames[is.na(k)]
save(k,file='~/Desktop/sixDegrees/k.RData')
print("k saved")
format(Sys.time(), "%H:%M:%S")

V(g)$label <- k
V(g)$degree <- degree(g)
save(g,file='~/Desktop/sixDegrees/g2.RData')

distMatrix <- shortest.paths(g, v=V(g), to=V(g))
save(distMatrix,file='~/Desktop/sixDegrees/distMatrix.RData')

print("distMatrix complete")
format(Sys.time(), "%H:%M:%S")
#save(playerMatrix,file='~/Desktop/sixDegrees/playerMatrix.RData')

rownames(distMatrix) <- k
colnames(distMatrix) <- rownames(distMatrix)
save(distMatrix,file='~/Desktop/sixDegrees/distMatrix2.RData')

print("distMatrix2 complete")
format(Sys.time(), "%H:%M:%S")

allPaths <- get.all.shortest.paths(g, from=V(g), to=V(g), mode = c("all", weights = NULL))

print("allPaths complete")
format(Sys.time(), "%H:%M:%S")

save(allPaths,file='~/Desktop/sixDegrees/allPaths.RData')
